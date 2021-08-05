from __future__ import print_function
import os.path
import time
from posix import listdir
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from apiclient.http import MediaFileUpload
from apiclient.discovery import build
import os


# If modifying these scopes, delete the file token.json.
SCOPES = ["https://www.googleapis.com/auth/drive"]
FULL_PATH = r"/home/michalina/"
DIR_NAME = "logs"


def main():
    """Shows basic usage of the Drive v3 API.
    Prints the names and ids of the first 10 files the user has access to.
    """
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists("token.json"):
        creds = Credentials.from_authorized_user_file("token.json", SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                "credentials.json", SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open("token.json", "w") as token:
            token.write(creds.to_json())

    service = build("drive", "v3", credentials=creds)
    # calling drive api and getting all folders that are in root folder, then looking for folder named 'Logs'

    results = (
        service.files()
        .list(
            q="'root' in parents and trashed = false",
            pageSize=10,
            fields="nextPageToken, files(id, name)",
        )
        .execute()
    )
    items = results.get("files", [])
    fileID = 0
    if not items:
        file_metadata = {
            "name": "Logs",
            "parents": "root",
            "mimeType": "application/vnd.google-apps.folder",
        }
        file = service.files().create(body=file_metadata, fields="id").execute()
        fileID = file.get("id")
    else:
        for item in items:
            if item["name"] == "Logs":
                fileID = item["id"]

    # SEARCHING IN LOCAL FOLDERS FOR TILL IN HOUR FOLDERS
    page_token = None
    while True:
        years_local = os.listdir(FULL_PATH + DIR_NAME)
        years_local_sorted = sorted(years_local)
        request = (
            service.files()
            .list(
                q="'"
                + str(fileID)
                + "' in parents and mimeType='application/vnd.google-apps.folder' and trashed = false",
                spaces="drive",
                fields="nextPageToken, files(id, name)",
                pageToken=page_token,
            )
            .execute()
        )
        years_remote = request.get("files", [])
        years_remote_sorted = sorted(years_remote, key=lambda k: k["name"])
        if len(years_remote_sorted) > 0:
            i = 0
            while len(years_local_sorted) - len(years_remote_sorted) > 0:
                while (
                    i >= len(years_remote_sorted)
                    or years_local_sorted[i] != years_remote_sorted[i]["name"]
                ) and i < len(years_local_sorted):
                    file_metadata = {
                        "name": years_local_sorted[i],
                        "parents": [fileID],
                        "mimeType": "application/vnd.google-apps.folder",
                    }
                    file = (
                        service.files()
                        .create(body=file_metadata, fields="id")
                        .execute()
                    )
                    years_local_sorted.pop(i)
                i = i + 1
        else:
            for i in range(0, len(years_local_sorted)):
                file_metadata = {
                    "name": years_local_sorted[i],
                    "parents": [fileID],
                    "mimeType": "application/vnd.google-apps.folder",
                }
                file = service.files().create(body=file_metadata, fields="id").execute()

        request = (
            service.files()
            .list(
                q="'"
                + str(fileID)
                + "' in parents and mimeType='application/vnd.google-apps.folder' and trashed = false",
                spaces="drive",
                fields="nextPageToken, files(id, name)",
                pageToken=page_token,
            )
            .execute()
        )
        years_remote = request.get("files", [])
        years_remote_sorted = sorted(years_remote, key=lambda k: k["name"])

        for year in years_remote_sorted:
            months_local = os.listdir(
                FULL_PATH + DIR_NAME + "/" + year["name"])
            months_local_sorted = sorted(months_local)
            request = (
                service.files()
                .list(
                    q="'"
                    + str(year["id"])
                    + "' in parents and mimeType='application/vnd.google-apps.folder' and trashed = false",
                    spaces="drive",
                    fields="nextPageToken, files(id, name)",
                    pageToken=page_token,
                )
                .execute()
            )
            months_remote = request.get("files", [])
            months_remote_sorted = sorted(
                months_remote, key=lambda k: k["name"])
            if len(months_remote_sorted) > 0:
                i = 0
                while len(months_local_sorted) - len(months_remote_sorted) > 0:
                    while (
                        i >= len(months_remote_sorted)
                        or months_local_sorted[i] != months_remote_sorted[i]["name"]
                    ) and i < len(months_local_sorted):
                        file_metadata = {
                            "name": months_local_sorted[i],
                            "parents": [year["id"]],
                            "mimeType": "application/vnd.google-apps.folder",
                        }
                        file = (
                            service.files()
                            .create(body=file_metadata, fields="id")
                            .execute()
                        )
                        months_local_sorted.pop(i)
                    i = i + 1
            else:
                for i in range(0, len(months_local_sorted)):
                    file_metadata = {
                        "name": months_local_sorted[i],
                        "parents": [year["id"]],
                        "mimeType": "application/vnd.google-apps.folder",
                    }
                    file = (
                        service.files()
                        .create(body=file_metadata, fields="id")
                        .execute()
                    )

            request = (
                service.files()
                .list(
                    q="'"
                    + str(year["id"])
                    + "' in parents and mimeType='application/vnd.google-apps.folder' and trashed = false",
                    spaces="drive",
                    fields="nextPageToken, files(id, name)",
                    pageToken=page_token,
                )
                .execute()
            )
            months_remote = request.get("files", [])
            months_remote_sorted = sorted(
                months_remote, key=lambda k: k["name"])

            for month in months_remote_sorted:
                days_local = os.listdir(
                    FULL_PATH + DIR_NAME + "/" +
                    year["name"] + "/" + month["name"]
                )
                days_local_sorted = sorted(days_local)
                request = (
                    service.files()
                    .list(
                        q="'"
                        + str(month["id"])
                        + "' in parents and mimeType='application/vnd.google-apps.folder' and trashed = false",
                        spaces="drive",
                        fields="nextPageToken, files(id, name)",
                        pageToken=page_token,
                    )
                    .execute()
                )
                days_remote = request.get("files", [])
                days_remote_sorted = sorted(
                    days_remote, key=lambda k: k["name"])
                if len(days_remote_sorted) > 0:
                    i = 0
                    while len(days_local_sorted) - len(days_remote_sorted) > 0:
                        while (
                            i >= len(days_remote_sorted)
                            or days_local_sorted[i] != days_remote_sorted[i]["name"]
                        ) and i < len(days_local_sorted):
                            file_metadata = {
                                "name": days_local_sorted[i],
                                "parents": [month["id"]],
                                "mimeType": "application/vnd.google-apps.folder",
                            }
                            file = (
                                service.files()
                                .create(body=file_metadata, fields="id")
                                .execute()
                            )
                            days_local_sorted.pop(i)
                        i = i + 1
                else:
                    for i in range(0, len(days_local_sorted)):
                        file_metadata = {
                            "name": days_local_sorted[i],
                            "parents": [month["id"]],
                            "mimeType": "application/vnd.google-apps.folder",
                        }
                        file = (
                            service.files()
                            .create(body=file_metadata, fields="id")
                            .execute()
                        )
                request = (
                    service.files()
                    .list(
                        q="'"
                        + str(month["id"])
                        + "' in parents and mimeType='application/vnd.google-apps.folder' and trashed = false",
                        spaces="drive",
                        fields="nextPageToken, files(id, name)",
                        pageToken=page_token,
                    )
                    .execute()
                )
                days_remote = request.get("files", [])
                days_remote_sorted = sorted(
                    days_remote, key=lambda k: k["name"])

                for day in days_remote_sorted:
                    hours_local = os.listdir(
                        FULL_PATH
                        + DIR_NAME
                        + "/"
                        + year["name"]
                        + "/"
                        + month["name"]
                        + "/"
                        + day["name"]
                    )
                    hours_local_sorted = sorted(hours_local)
                    request = (
                        service.files()
                        .list(
                            q="'"
                            + str(day["id"])
                            + "' in parents and mimeType='application/vnd.google-apps.folder' and trashed = false",
                            spaces="drive",
                            fields="nextPageToken, files(id, name)",
                            pageToken=page_token,
                        )
                        .execute()
                    )
                    hours_remote = request.get("files", [])
                    hours_remote_sorted = sorted(
                        hours_remote, key=lambda k: k["name"])
                    if len(hours_remote_sorted) > 0:
                        i = 0
                        while len(hours_local_sorted) - len(hours_remote_sorted) > 0:
                            while (
                                i >= len(hours_remote_sorted)
                                or hours_local_sorted[i]
                                != hours_remote_sorted[i]["name"]
                            ) and i < len(hours_local_sorted):
                                file_metadata = {
                                    "name": hours_local_sorted[i],
                                    "parents": [day["id"]],
                                    "mimeType": "application/vnd.google-apps.folder",
                                }
                                file = (
                                    service.files()
                                    .create(body=file_metadata, fields="id")
                                    .execute()
                                )
                                hours_local_sorted.pop(i)
                            i = i + 1
                    else:
                        for i in range(0, len(hours_local_sorted)):
                            file_metadata = {
                                "name": hours_local_sorted[i],
                                "parents": [day["id"]],
                                "mimeType": "application/vnd.google-apps.folder",
                            }
                            file = (
                                service.files()
                                .create(body=file_metadata, fields="id")
                                .execute()
                            )
                    request = (
                        service.files()
                        .list(
                            q="'"
                            + str(day["id"])
                            + "' in parents and mimeType='application/vnd.google-apps.folder' and trashed = false",
                            spaces="drive",
                            fields="nextPageToken, files(id, name)",
                            pageToken=page_token,
                        )
                        .execute()
                    )
                    hours_remote = request.get("files", [])
                    hours_remote_sorted = sorted(
                        hours_remote, key=lambda k: k["name"])

                    for hour in hours_remote_sorted:
                        log_files_local = os.listdir(
                            FULL_PATH
                            + DIR_NAME
                            + "/"
                            + year["name"]
                            + "/"
                            + month["name"]
                            + "/"
                            + day["name"]
                            + "/"
                            + hour["name"]
                        )
                        log_files_local_sorted = sorted(log_files_local)
                        request = (
                            service.files()
                            .list(
                                q="'"
                                + str(hour["id"])
                                + "' in parents and mimeType!='application/vnd.google-apps.folder' and trashed = false",
                                spaces="drive",
                                fields="nextPageToken, files(id, name)",
                                pageToken=page_token,
                            )
                            .execute()
                        )
                        log_files_remote = request.get("files", [])
                        log_files_remote_sorted = sorted(
                            log_files_remote, key=lambda k: k["name"]
                        )
                        if len(log_files_remote_sorted) > 0:
                            i = 0
                            while (
                                len(log_files_local_sorted)
                                - len(log_files_remote_sorted)
                                > 0
                            ):

                                while (
                                    i >= len(log_files_remote_sorted)
                                    or log_files_local_sorted[i]
                                    != log_files_remote_sorted[i]["name"]
                                ) and i < len(log_files_local_sorted):
                                    print("i: ", i)
                                    print("local: ", log_files_local_sorted[i])
                                    file_metadata = {
                                        "name": log_files_local_sorted[i],
                                        "parents": [hour["id"]],
                                    }
                                    media = MediaFileUpload(
                                        FULL_PATH
                                        + DIR_NAME
                                        + "/"
                                        + year["name"]
                                        + "/"
                                        + month["name"]
                                        + "/"
                                        + day["name"]
                                        + "/"
                                        + hour["name"]
                                        + "/"
                                        + log_files_local_sorted[i],
                                        mimetype="txt/csv",
                                    )
                                    file = (
                                        service.files()
                                        .create(
                                            body=file_metadata,
                                            media_body=media,
                                            fields="id",
                                        )
                                        .execute()
                                    )
                                    log_files_local_sorted.pop(i)
                                i = i + 1

                        else:
                            for i in range(0, len(log_files_local_sorted)):
                                print("i: ", i)
                                file_metadata = {
                                    "name": log_files_local_sorted[i],
                                    "parents": [hour["id"]],
                                }
                                media = MediaFileUpload(
                                    FULL_PATH
                                    + DIR_NAME
                                    + "/"
                                    + year["name"]
                                    + "/"
                                    + month["name"]
                                    + "/"
                                    + day["name"]
                                    + "/"
                                    + hour["name"]
                                    + "/"
                                    + log_files_local_sorted[i],
                                    mimetype="txt/csv",
                                )
                                file = (
                                    service.files()
                                    .create(
                                        body=file_metadata,
                                        media_body=media,
                                        fields="id",
                                    )
                                    .execute()
                                )
    time.sleep(60)


if __name__ == "__main__":
    main()
