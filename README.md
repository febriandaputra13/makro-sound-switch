# Makro Sound Switch

A portable Windows app for switching audio devices and controlling media with keyboard shortcuts.

## Why I made this

Switching from a headset to speakers often means changing more than one setting. The output needs to change, the microphone might need to change too, and sometimes the music needs to pause. Doing that through Windows settings gets repetitive.

Makro Sound Switch brings those steps into named scenarios. Set up the devices and actions once, assign a shortcut, and use it whenever you need that setup. It runs quietly in the background and keeps its settings beside the executable, so moving it to another folder is straightforward.

## What it can do

- Create named scenarios and turn their shortcuts on or off.
- Use multi-key shortcuts, including Windows + F12 and combinations of five or more keys.
- Switch the output device, input device, or both.
- Add Play/Pause, Next, Prev, and Mute/Unmute actions.
- Run several actions from one shortcut, in the order you choose.
- Drag keys and actions to rearrange them.
- Start hidden, optionally launch at Windows sign-in, and choose what happens when the window closes.

There are no toast notifications, accounts, downloads at runtime, or telemetry.

## A simple setup

| Scenario | Shortcut | Actions |
| --- | --- | --- |
| Headset | Windows + F12 | Switch output to the headset and input to its microphone |
| Speakers | Windows + F11 | Switch output to speakers and input to a desk microphone |
| Music | Ctrl + Alt + M | Toggle Play/Pause |

These are examples. Choose your own keys and the devices connected to your computer.

## How to run

Windows 10 or 11 with .NET Framework 4.8 is recommended.

1. On this repository page, click **Code → Download ZIP**.
2. Right-click the downloaded ZIP and choose **Extract All**. Extract it to a folder where you can save files.
3. Open the extracted folder and double-click **Makro Sound Switch V.0.1.exe**. Run it from the extracted folder, not from inside the ZIP.
4. The app starts hidden in the background. Find its slider icon in the Windows system tray; it may be under the **^** arrow. Double-click the icon to open the app. Running the EXE again also opens the existing instance.
5. Create a scenario and save it. The app creates a `config` folder beside the EXE to store your scenarios and settings.

The repository includes the ready-to-run EXE, so no build or installation is needed. The source-building instructions below are optional.

## Build from source (optional)

Open PowerShell in the extracted repository folder and run:

```powershell
powershell -File .\build.ps1
```

The script uses the Windows C# compiler, requires no third-party packages, and creates:

```text
dist\Makro Sound Switch V.0.1.exe
```

The build also updates the ready-to-run EXE at the repository root. Double-click either copy to run the app.

## Create a scenario

1. Click **New scenario** and give it a name.
2. Select the shortcut keys. Use **Add key** if you need more.
3. Click **Add a feature**, then choose an action. Output and Input actions include a device dropdown.
4. Use **Add another feature** for additional actions. Drag the handles to set their order.
5. Click **Save scenario**.

Hold all shortcut keys together to activate the scenario. Their displayed order does not change how the shortcut is pressed. Features execute from top to bottom. **Apply now** also lets you run a scenario manually.

Play/Pause toggles playback in the active compatible media player. Mute/Unmute toggles the default output at that point in the action list, so put an Output action first if you want to mute or unmute a particular device.

## Portable settings

Scenarios and app preferences are saved beside the EXE:

```text
Makro Sound Switch V.0.1.exe
config/
  scenarios.xml
  scenarios.xml.bak
```

Copy the EXE and the `config` folder together when moving the app. The config folder is personal and is excluded from this repository.

The optional Windows-startup setting uses a per-user registry entry. After moving the app to another location or computer, save that setting again to register its new path.

## Closing the window

In **Settings**, choose one of these options:

- **Close app:** stop the app and its shortcuts.
- **Close to taskbar:** minimize the window.
- **Close to hidden app:** keep shortcuts active in the background.

The tray menu's **Exit** command always stops the app.

## Source and tests

- `src/SoundSwitch.cs` — application source.
- `assets/` — the slider icon.
- `build.ps1` — local build script.
- `test.ps1` and `tests/` — regression checks.

Run the checks with:

```powershell
powershell -File .\test.ps1
```

Builds and test output stay in the ignored `dist` folder. Some tests open temporary windows and check Windows audio APIs.

## A few things to know

Your keyboard must support the number of keys you hold together. Some protected Windows shortcuts take precedence. Media actions depend on the player's support for Windows media controls, and apps with their own selected audio device may not follow a Windows default-device change.

Global shortcuts use a keyboard hook. Held-key state stays in memory; the app does not record typed text or save a key history. The application has no network client or remote-control feature. See [SECURITY.md](SECURITY.md) for the security review and its limits.

Current version: **0.1**.
