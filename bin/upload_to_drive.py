from __future__ import print_function
from drive_api_handler import DriveApiHandler
from change_log_handler import ChangeLog

def main():
    handler = ChangeLog()

    # SEARCHING IN LOCAL FOLDERS FOR TILL IN HOUR FOLDERS
    while True:
        handler.logChangesInFolder()



if __name__ == "__main__":
    main()
