## PowerShell File Integrity Monitoring (FIM)


## Overview
This project provides a PowerShell script for File Integrity Monitoring (FIM). The script tracks changes in specified directories and logs any modifications, additions, or deletions of files. This tool is useful for ensuring the integrity and security of your system files by detecting unauthorized changes.

## Features
- Real-time Monitoring: Continuously monitors specified directories for any changes.
- Logging: Logs all detected changes with detailed information including the type of change, timestamp, and file path.
- Customizable: Easily configure directories to monitor and log file locations.
- Alerts: Optionally sends alerts for detected changes (email, SMS, etc.).
- Scheduled Scans: Configure the script to run at scheduled intervals.

## Installation
1. Clone the repository:
    
        git clone https://github.com/iamibie/PowerShell-FIM.git
        cd PowerShell-FIM
2. Ensure you have PowerShell 7.1 or later installed.

3. Modify the configuration file (config.json) to specify the directories you want to monitor and the log file location.

## Usage
Run the script to start monitoring:

    ./fim.ps1
## Configuration
The config.json file allows you to specify:
  - Directories to monitor: List of directories that you want the script to monitor for changes.
  - Log file location: Path where the log file will be saved.
  - Alert settings (optional): Configuration for email or SMS alerts.

Example config.json:

    {
      "Directories": [
        "C:\\Path\\To\\Directory1",
        "C:\\Path\\To\\Directory2"
      ],
      "LogFile": "C:\\Path\\To\\LogFile.log",
      "Alerts": {
        "Email": {
          "Enabled": true,
          "Recipient": "admin@example.com",
          "SMTPServer": "smtp.example.com",
          "SMTPPort": 587,
          "Username": "user@example.com",
          "Password": "password"
        },
        "SMS": {
          "Enabled": false,
          "PhoneNumber": "+1234567890",
          "SMSServer": "sms.example.com",
          "APIKey": "your_api_key"
        }
      }
    }
## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
