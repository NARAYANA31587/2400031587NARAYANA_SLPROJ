# SmartAttendAI — Windows Setup Guide

## 1. Requirements
- Windows 10 or Windows 11
- Python 3.11 (recommended) or Python 3.12
- VS Code (optional)
- A webcam for face enrollment / attendance

Install Python from https://www.python.org/downloads/windows/. During setup, select **Add Python to PATH**.

## 2. Extract and open
1. Extract the ZIP file.
2. Open the `SmartAttendAI_Redesign` folder in VS Code.
3. Open **Terminal → New Terminal**.

## 3. Run the application (easiest way)
Double-click `run_windows.bat` in File Explorer, or run this in PowerShell:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\run_windows.bat
```

The first run creates `.venv`, installs packages from `requirements.txt`, creates the `data` folder and starts Flask.

## 4. Open the website
Open this address in Chrome or Edge:

http://127.0.0.1:5001

On the first run, the app redirects to `/setup`. Create the first administrator account, then sign in.

Useful pages:
- Dashboard: `http://127.0.0.1:5001/`
- Student enrollment: `http://127.0.0.1:5001/enroll`
- Attendance kiosk: `http://127.0.0.1:5001/kiosk`
- Reports: `http://127.0.0.1:5001/reports`

The server must remain running in the terminal while you use the website. Stop it with **CTRL+C**.

## 5. Webcam permission
When enrolling a student, allow camera access in the browser. Camera access works on `localhost` / `127.0.0.1` in supported browsers. Close other apps that may be using the webcam.

## 6. Existing student data
This ZIP does not contain your previous database or face photos. If you need your old records, copy these from your old project into this project's `data` folder:

- `data/smartattend.db`
- `data/faces/` (the complete folder)

Back up both before copying. Do not overwrite your only original copy. If you want a clean test, leave them out; the app will create a new empty database.

## 7. Manual setup (if the batch file does not work)
Run these commands from the `SmartAttendAI_Redesign` folder:

```powershell
py -3.11 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python app.py
```

If PowerShell blocks activation, use the batch launcher, or run:
`Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`

## 8. Common fixes
- **`py` is not recognized:** reinstall Python and enable the Python Launcher / Add Python to PATH.
- **OpenCV install fails:** use Python 3.11 or 3.12 (64-bit), then delete `.venv` and run the launcher again.
- **Kiosk does not detect faces or shows recognition unavailable:** run `run_windows.bat` again to install the supported OpenCV contrib version, then restart the app. Do not install `opencv-python` separately; it can conflict with the contrib package needed for face detection and recognition.
- **Port 5001 is busy:** in PowerShell run `$env:PORT=5002; python app.py`, then open `http://127.0.0.1:5002`.
- **Camera not showing:** allow camera permission in browser settings and close apps such as Camera, Zoom, or Teams.
- **Changes not appearing:** refresh the browser with `Ctrl+F5`.

## Notes
This is a local Flask application. It is not publicly hosted just because it runs on your laptop. For a public website link, deploy it to a hosting service and configure persistent storage for the SQLite database and face images. Do not expose real student face data publicly.
