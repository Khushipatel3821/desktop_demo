#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <flutter/method_channel.h>
#include <windows.h>
#include <vector>
#include <string>
#include "flutter_window.h"
#include "utils.h"
#include <flutter/standard_method_codec.h>

namespace {
    int GetSystemIdleTime() {
        LASTINPUTINFO lii;
        lii.cbSize = sizeof(LASTINPUTINFO);

        if (GetLastInputInfo(&lii)) {
            DWORD currentTime = GetTickCount(); // Same time base as lii.dwTime
            return static_cast<int>(currentTime - lii.dwTime);
        }
        return 0;
    }

    void LockSystemScreen() {
        LockWorkStation();
    }
// Platform channel handler class
    class NativeBridge {
    public:
        static void GetIdleTime(const flutter::MethodCall<> &call,
                                std::unique_ptr<flutter::MethodResult<>> result) {
            int idleTime = GetSystemIdleTime();  // Call the function to get idle time
            result->Success(idleTime);
        }

        static void OnScreenLock(const flutter::MethodCall<> &call,
                                 std::unique_ptr<flutter::MethodResult<>> result) {
            // Notify Flutter that the screen was locked
            result->Success("Screen is locked");
        }

        static void OnScreenUnlock(const flutter::MethodCall<> &call,
                                   std::unique_ptr<flutter::MethodResult<>> result) {
            // Notify Flutter that the screen was unlocked
            result->Success("Screen is unlocked");
        }

        static void RegisterWithEngine(flutter::FlutterEngine* engine) {
            auto messenger = engine->messenger();

            // Create the method channel
            auto channel = std::make_unique<flutter::MethodChannel<>>(
                    messenger, "com.example/native", &flutter::StandardMethodCodec::GetInstance());

            // Set the method handler
            channel->SetMethodCallHandler(
                    [](const flutter::MethodCall<>& call, std::unique_ptr<flutter::MethodResult<>> result) {
                        if (call.method_name() == "getIdleTime") {
                            GetIdleTime(call, std::move(result));
                        } else if (call.method_name() == "onScreenLock") {
                            OnScreenLock(call, std::move(result));
                        } else if (call.method_name() == "onScreenUnlock") {
                            OnScreenUnlock(call, std::move(result));
                        } else if (call.method_name() == "lockSystemScreen") {
                            LockSystemScreen();
                            result->Success("Screen locked via native code"); // Respond to Dart
                        } else {
                            result->NotImplemented();
                        }
                    });

            // No need to call AddPlugin; just keep channel alive if needed
            // Optionally store channel somewhere if it needs to persist
        }
    };

}  // namespace


int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(L"desktop_demo_fl", origin, size)) {
    return EXIT_FAILURE;
  }

  window.SetQuitOnClose(true);
NativeBridge::RegisterWithEngine(window.GetEngine());
  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
