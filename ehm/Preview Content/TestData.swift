//
//  TestData.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation

let testUser: Data = """
{
    "user": {
        "id": 1,
        "login": "gianlorenzo@occhipinti.dev",
        "admin": false,
        "firstname": "Gianlorenzo",
        "lastname": "Occhipinti",
        "created_on": "2022-09-02T13:26:50Z",
        "updated_on": "2024-10-04T12:29:44Z",
        "last_login_on": "2024-10-04T12:29:44Z",
        "passwd_changed_on": "2022-09-05T07:03:15Z",
        "avatar_url": "https://www.gravatar.com/avatar/cd3d1ee607553332a30f79984a93056c?default=mm",
        "twofa_scheme": "totp",
        "api_key": ""
    }
}         
""".data(using: .utf8)!

let testFeature_te01: Data = """
    {
        "id": 163582,
        "project": {
            "id": 311,
            "name": "renuo 1"
        },
        "issue": {
            "id": 212
        },
        "user": {
            "id": 12,
            "name": "Gianlorenzo Occhipinti"
        },
        "activity": {
            "id": 1,
            "name": "Entwicklung"
        },
        "hours": 1.67,
        "comments": "This was fun",
        "spent_on": "2023-01-27",
        "created_on": "2023-01-27T18:07:21Z",
        "updated_on": "2023-01-27T18:07:21Z"
    }
""".data(using: .utf8)!

let testFeature_te02: Data = """
{
    "time_entries": [
        {
            "id": 2131,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.67,
            "comments": "This was fun",
            "spent_on": "2023-01-27",
            "created_on": "2023-01-27T18:07:21Z",
            "updated_on": "2023-01-27T18:07:21Z"
        },
        {
            "id": 163581,
            "project": {
                "id": 170,
                "name": "General Admin"
            },
            "issue": {
                "id": 1339
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.5,
            "comments": "This was fun",
            "spent_on": "2023-01-27",
            "created_on": "2023-01-27T18:06:44Z",
            "updated_on": "2023-01-27T18:06:44Z"
        }
    ],
    "total_count": 369,
    "offset": 10,
    "limit": 2
}
""".data(using: .utf8)!

let testFeature_te04: Data = """
{
    "time_entries": [
        {
            "id": 163729,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.45,
            "comments": "This was fun",
            "spent_on": "2023-01-30",
            "created_on": "2023-01-30T18:33:48Z",
            "updated_on": "2023-01-30T18:33:48Z"
        },
        {
            "id": 163728,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.57,
            "comments": "This was fun",
            "spent_on": "2023-01-30",
            "created_on": "2023-01-30T18:33:33Z",
            "updated_on": "2023-01-30T18:33:33Z"
        },
        {
            "id": 163665,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 4.83,
            "comments": " This was fun",
            "spent_on": "2023-01-30",
            "created_on": "2023-01-30T12:34:51Z",
            "updated_on": "2023-01-30T12:34:51Z"
        },
        {
            "id": 163582,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.67,
            "comments": "This was fun",
            "spent_on": "2023-01-27",
            "created_on": "2023-01-27T18:07:21Z",
            "updated_on": "2023-01-27T18:07:21Z"
        },
        {
            "id": 163581,
            "project": {
                "id": 170,
                "name": "General Admin"
            },
            "issue": {
                "id": 1339
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.5,
            "comments": "This was fun",
            "spent_on": "2023-01-27",
            "created_on": "2023-01-27T18:06:44Z",
            "updated_on": "2023-01-27T18:06:44Z"
        },
        {
            "id": 163580,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 16764
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.5,
            "comments": "This was fun",
            "spent_on": "2023-01-27",
            "created_on": "2023-01-27T18:06:05Z",
            "updated_on": "2023-01-27T18:06:05Z"
        },
        {
            "id": 163579,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.0,
            "comments": "This was fun",
            "spent_on": "2023-01-27",
            "created_on": "2023-01-27T18:05:47Z",
            "updated_on": "2023-01-27T18:05:47Z"
        },
        {
            "id": 163578,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 16764
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.0,
            "comments": "This was fun",
            "spent_on": "2023-01-27",
            "created_on": "2023-01-27T18:05:25Z",
            "updated_on": "2023-01-27T18:05:25Z"
        },
        {
            "id": 163577,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.25,
            "comments": "This was fun",
            "spent_on": "2023-01-27",
            "created_on": "2023-01-27T18:04:57Z",
            "updated_on": "2023-01-27T18:04:57Z"
        },
        {
            "id": 163576,
            "project": {
                "id": 170,
                "name": "General Admin"
            },
            "issue": {
                "id": 1339
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.75,
            "comments": "This was fun",
            "spent_on": "2023-01-27",
            "created_on": "2023-01-27T18:04:26Z",
            "updated_on": "2023-01-27T18:04:26Z"
        },
        {
            "id": 163456,
            "project": {
                "id": 146,
                "name": "wg-interns"
            },
            "issue": {
                "id": 17977
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.5,
            "comments": "This was fun",
            "spent_on": "2023-01-26",
            "created_on": "2023-01-27T09:45:48Z",
            "updated_on": "2023-01-27T09:45:48Z"
        },
        {
            "id": 163424,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.83,
            "comments": " This was fun",
            "spent_on": "2023-01-26",
            "created_on": "2023-01-26T19:04:43Z",
            "updated_on": "2023-01-26T19:04:43Z"
        },
        {
            "id": 163422,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 4.22,
            "comments": " This was fun",
            "spent_on": "2023-01-26",
            "created_on": "2023-01-26T19:04:00Z",
            "updated_on": "2023-01-26T19:04:00Z"
        },
        {
            "id": 163419,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.92,
            "comments": "This was fun",
            "spent_on": "2023-01-26",
            "created_on": "2023-01-26T19:03:27Z",
            "updated_on": "2023-01-26T19:03:27Z"
        },
        {
            "id": 163328,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.33,
            "comments": "This was fun",
            "spent_on": "2023-01-25",
            "created_on": "2023-01-25T18:05:05Z",
            "updated_on": "2023-01-25T18:05:05Z"
        },
        {
            "id": 163327,
            "project": {
                "id": 138,
                "name": "Renuo Investments"
            },
            "issue": {
                "id": 5000
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.45,
            "comments": "This was fun",
            "spent_on": "2023-01-25",
            "created_on": "2023-01-25T18:04:38Z",
            "updated_on": "2023-01-25T18:04:38Z"
        },
        {
            "id": 163326,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.05,
            "comments": "This was fun",
            "spent_on": "2023-01-25",
            "created_on": "2023-01-25T18:04:21Z",
            "updated_on": "2023-01-25T18:04:21Z"
        },
        {
            "id": 163325,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.5,
            "comments": "This was fun",
            "spent_on": "2023-01-25",
            "created_on": "2023-01-25T18:03:30Z",
            "updated_on": "2023-01-25T18:03:30Z"
        },
        {
            "id": 163324,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.5,
            "comments": "This was fun",
            "spent_on": "2023-01-25",
            "created_on": "2023-01-25T18:03:01Z",
            "updated_on": "2023-01-25T18:03:01Z"
        },
        {
            "id": 163323,
            "project": {
                "id": 138,
                "name": "Renuo Investments"
            },
            "issue": {
                "id": 5000
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 4.75,
            "comments": "This was fun",
            "spent_on": "2023-01-25",
            "created_on": "2023-01-25T18:02:32Z",
            "updated_on": "2023-01-25T18:02:32Z"
        },
        {
            "id": 163322,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.58,
            "comments": "This was fun",
            "spent_on": "2023-01-25",
            "created_on": "2023-01-25T18:02:05Z",
            "updated_on": "2023-01-25T18:02:05Z"
        },
        {
            "id": 163232,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.7,
            "comments": "This was fun",
            "spent_on": "2023-01-24",
            "created_on": "2023-01-24T18:22:25Z",
            "updated_on": "2023-01-24T18:22:25Z"
        },
        {
            "id": 163230,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 5.42,
            "comments": " This was fun",
            "spent_on": "2023-01-24",
            "created_on": "2023-01-24T18:21:45Z",
            "updated_on": "2023-01-24T18:21:45Z"
        },
        {
            "id": 163229,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.75,
            "comments": " This was fun",
            "spent_on": "2023-01-24",
            "created_on": "2023-01-24T18:21:19Z",
            "updated_on": "2023-01-24T18:21:19Z"
        },
        {
            "id": 163228,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.25,
            "comments": " This was fun",
            "spent_on": "2023-01-24",
            "created_on": "2023-01-24T18:21:00Z",
            "updated_on": "2023-01-24T18:21:00Z"
        },
        {
            "id": 163136,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 4.64,
            "comments": " This was fun",
            "spent_on": "2023-01-23",
            "created_on": "2023-01-23T18:08:24Z",
            "updated_on": "2023-01-23T18:08:24Z"
        },
        {
            "id": 163135,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 5.83,
            "comments": "This was fun",
            "spent_on": "2023-01-23",
            "created_on": "2023-01-23T18:08:12Z",
            "updated_on": "2023-01-23T18:08:12Z"
        },
        {
            "id": 163011,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.33,
            "comments": "This was fun",
            "spent_on": "2023-01-20",
            "created_on": "2023-01-20T17:20:29Z",
            "updated_on": "2023-01-20T17:20:29Z"
        },
        {
            "id": 163002,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.42,
            "comments": "This was fun",
            "spent_on": "2023-01-20",
            "created_on": "2023-01-20T16:38:25Z",
            "updated_on": "2023-01-20T16:38:25Z"
        },
        {
            "id": 163001,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 4.75,
            "comments": "This was fun",
            "spent_on": "2023-01-20",
            "created_on": "2023-01-20T16:37:34Z",
            "updated_on": "2023-01-20T16:37:34Z"
        },
        {
            "id": 162892,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.75,
            "comments": "This was fun",
            "spent_on": "2023-01-19",
            "created_on": "2023-01-19T17:53:55Z",
            "updated_on": "2023-01-19T17:53:55Z"
        },
        {
            "id": 162891,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.9,
            "comments": "This was fun",
            "spent_on": "2023-01-19",
            "created_on": "2023-01-19T17:53:45Z",
            "updated_on": "2023-01-19T17:53:45Z"
        },
        {
            "id": 162889,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.08,
            "comments": "This was fun",
            "spent_on": "2023-01-19",
            "created_on": "2023-01-19T17:53:12Z",
            "updated_on": "2023-01-19T17:53:12Z"
        },
        {
            "id": 162888,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.0,
            "comments": "This was fun",
            "spent_on": "2023-01-19",
            "created_on": "2023-01-19T17:52:37Z",
            "updated_on": "2023-01-19T17:52:37Z"
        },
        {
            "id": 162787,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.68,
            "comments": "This was fun",
            "spent_on": "2023-01-18",
            "created_on": "2023-01-18T18:10:46Z",
            "updated_on": "2023-01-18T18:10:46Z"
        },
        {
            "id": 162786,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.25,
            "comments": "This was fun",
            "spent_on": "2023-01-18",
            "created_on": "2023-01-18T18:10:17Z",
            "updated_on": "2023-01-18T18:10:17Z"
        },
        {
            "id": 162785,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.95,
            "comments": " This was fun",
            "spent_on": "2023-01-18",
            "created_on": "2023-01-18T18:09:19Z",
            "updated_on": "2023-01-18T18:09:19Z"
        },
        {
            "id": 162677,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.19,
            "comments": " This was fun",
            "spent_on": "2023-01-17",
            "created_on": "2023-01-17T18:41:20Z",
            "updated_on": "2023-01-17T18:41:20Z"
        },
        {
            "id": 162676,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 4.0,
            "comments": "This was fun",
            "spent_on": "2023-01-17",
            "created_on": "2023-01-17T18:41:06Z",
            "updated_on": "2023-01-17T18:41:06Z"
        },
        {
            "id": 162675,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.93,
            "comments": "This was fun",
            "spent_on": "2023-01-17",
            "created_on": "2023-01-17T18:40:26Z",
            "updated_on": "2023-01-17T18:40:26Z"
        },
        {
            "id": 162592,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.67,
            "comments": "This was fun",
            "spent_on": "2023-01-16",
            "created_on": "2023-01-16T21:10:31Z",
            "updated_on": "2023-01-16T21:10:31Z"
        },
        {
            "id": 162591,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.5,
            "comments": " This was fun",
            "spent_on": "2023-01-16",
            "created_on": "2023-01-16T17:59:39Z",
            "updated_on": "2023-01-16T17:59:39Z"
        },
        {
            "id": 162590,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.25,
            "comments": "This was fun",
            "spent_on": "2023-01-16",
            "created_on": "2023-01-16T17:59:25Z",
            "updated_on": "2023-01-16T17:59:25Z"
        },
        {
            "id": 162589,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 16764
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.75,
            "comments": "This was fun",
            "spent_on": "2023-01-16",
            "created_on": "2023-01-16T17:58:06Z",
            "updated_on": "2023-01-16T17:58:06Z"
        },
        {
            "id": 162588,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19197
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 4.5,
            "comments": "This was fun",
            "spent_on": "2023-01-16",
            "created_on": "2023-01-16T17:57:30Z",
            "updated_on": "2023-01-16T17:57:30Z"
        },
        {
            "id": 162484,
            "project": {
                "id": 170,
                "name": "General Admin"
            },
            "issue": {
                "id": 1339
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.0,
            "comments": "This was fun",
            "spent_on": "2023-01-13",
            "created_on": "2023-01-15T21:56:49Z",
            "updated_on": "2023-01-15T21:56:49Z"
        },
        {
            "id": 162462,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.01,
            "comments": "This was fun",
            "spent_on": "2023-01-13",
            "created_on": "2023-01-13T17:30:27Z",
            "updated_on": "2023-01-13T17:30:27Z"
        },
        {
            "id": 162461,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19404
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.5,
            "comments": "This was fun",
            "spent_on": "2023-01-13",
            "created_on": "2023-01-13T17:30:00Z",
            "updated_on": "2023-01-13T17:30:00Z"
        },
        {
            "id": 162460,
            "project": {
                "id": 170,
                "name": "General Admin"
            },
            "issue": {
                "id": 1339
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.5,
            "comments": "This was fun",
            "spent_on": "2023-01-13",
            "created_on": "2023-01-13T17:28:52Z",
            "updated_on": "2023-01-13T17:28:52Z"
        },
        {
            "id": 162458,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 16764
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.5,
            "comments": "This was fun",
            "spent_on": "2023-01-13",
            "created_on": "2023-01-13T17:25:37Z",
            "updated_on": "2023-01-13T17:25:37Z"
        },
        {
            "id": 162457,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 16764
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.5,
            "comments": "This was fun",
            "spent_on": "2023-01-13",
            "created_on": "2023-01-13T17:25:16Z",
            "updated_on": "2023-01-13T17:25:16Z"
        },
        {
            "id": 162456,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 16764
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.0,
            "comments": "This was fun",
            "spent_on": "2023-01-13",
            "created_on": "2023-01-13T17:24:34Z",
            "updated_on": "2023-01-13T17:24:34Z"
        },
        {
            "id": 162455,
            "project": {
                "id": 170,
                "name": "General Admin"
            },
            "issue": {
                "id": 4999
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.0,
            "comments": "This was fun",
            "spent_on": "2023-01-13",
            "created_on": "2023-01-13T17:23:25Z",
            "updated_on": "2023-01-13T17:23:25Z"
        },
        {
            "id": 162454,
            "project": {
                "id": 170,
                "name": "General Admin"
            },
            "issue": {
                "id": 1339
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.0,
            "comments": "This was fun",
            "spent_on": "2023-01-13",
            "created_on": "2023-01-13T17:22:40Z",
            "updated_on": "2023-01-13T17:22:40Z"
        },
        {
            "id": 162352,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 4.25,
            "comments": "This was fun",
            "spent_on": "2023-01-12",
            "created_on": "2023-01-12T18:30:14Z",
            "updated_on": "2023-01-12T18:30:14Z"
        },
        {
            "id": 162351,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19404
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.0,
            "comments": " This was fun",
            "spent_on": "2023-01-12",
            "created_on": "2023-01-12T18:20:21Z",
            "updated_on": "2023-01-12T18:20:21Z"
        },
        {
            "id": 162349,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.0,
            "comments": "This was fun",
            "spent_on": "2023-01-12",
            "created_on": "2023-01-12T18:18:46Z",
            "updated_on": "2023-01-12T18:18:46Z"
        },
        {
            "id": 162348,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.83,
            "comments": "This was fun",
            "spent_on": "2023-01-12",
            "created_on": "2023-01-12T18:18:12Z",
            "updated_on": "2023-01-12T18:18:12Z"
        },
        {
            "id": 162248,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.84,
            "comments": "This was fun",
            "spent_on": "2023-01-11",
            "created_on": "2023-01-11T18:20:35Z",
            "updated_on": "2023-01-11T18:20:35Z"
        },
        {
            "id": 162247,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.17,
            "comments": "This was fun",
            "spent_on": "2023-01-11",
            "created_on": "2023-01-11T18:20:09Z",
            "updated_on": "2023-01-11T18:20:09Z"
        },
        {
            "id": 162246,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19404
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.08,
            "comments": " This was fun",
            "spent_on": "2023-01-11",
            "created_on": "2023-01-11T18:19:40Z",
            "updated_on": "2023-01-11T18:19:40Z"
        },
        {
            "id": 162245,
            "project": {
                "id": 138,
                "name": "Renuo Investments"
            },
            "issue": {
                "id": 11111
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.0,
            "comments": "This was fun",
            "spent_on": "2023-01-11",
            "created_on": "2023-01-11T18:19:02Z",
            "updated_on": "2023-01-11T18:19:02Z"
        },
        {
            "id": 162244,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.83,
            "comments": " This was fun",
            "spent_on": "2023-01-11",
            "created_on": "2023-01-11T18:18:45Z",
            "updated_on": "2023-01-11T18:18:45Z"
        },
        {
            "id": 162164,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.68,
            "comments": "This was fun",
            "spent_on": "2023-01-10",
            "created_on": "2023-01-10T18:03:59Z",
            "updated_on": "2023-01-10T18:03:59Z"
        },
        {
            "id": 162163,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19404
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.93,
            "comments": "This was fun",
            "spent_on": "2023-01-10",
            "created_on": "2023-01-10T18:03:19Z",
            "updated_on": "2023-01-10T18:03:19Z"
        },
        {
            "id": 162162,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 5.25,
            "comments": "This was fun",
            "spent_on": "2023-01-10",
            "created_on": "2023-01-10T18:01:22Z",
            "updated_on": "2023-01-10T18:01:22Z"
        },
        {
            "id": 162064,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 5.78,
            "comments": " This was fun",
            "spent_on": "2023-01-09",
            "created_on": "2023-01-09T18:03:13Z",
            "updated_on": "2023-01-09T18:03:13Z"
        },
        {
            "id": 162063,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 4.05,
            "comments": "This was fun",
            "spent_on": "2023-01-09",
            "created_on": "2023-01-09T17:48:44Z",
            "updated_on": "2023-01-09T17:48:44Z"
        },
        {
            "id": 161968,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19404
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.0,
            "comments": "This was fun",
            "spent_on": "2023-01-06",
            "created_on": "2023-01-06T18:29:22Z",
            "updated_on": "2023-01-06T18:29:22Z"
        },
        {
            "id": 161963,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18565
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 2.0,
            "comments": "This was fun",
            "spent_on": "2023-01-06",
            "created_on": "2023-01-06T16:47:32Z",
            "updated_on": "2023-01-06T16:47:32Z"
        },
        {
            "id": 161962,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.25,
            "comments": "This was fun",
            "spent_on": "2023-01-06",
            "created_on": "2023-01-06T16:46:49Z",
            "updated_on": "2023-01-06T16:46:49Z"
        },
        {
            "id": 161961,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.95,
            "comments": "This was fun",
            "spent_on": "2023-01-06",
            "created_on": "2023-01-06T16:46:10Z",
            "updated_on": "2023-01-06T16:46:10Z"
        },
        {
            "id": 161964,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18565
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.25,
            "comments": "This was fun",
            "spent_on": "2023-01-05",
            "created_on": "2023-01-06T16:53:56Z",
            "updated_on": "2023-01-06T16:53:56Z"
        },
        {
            "id": 161861,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.28,
            "comments": "This was fun",
            "spent_on": "2023-01-05",
            "created_on": "2023-01-05T22:06:09Z",
            "updated_on": "2023-01-05T22:06:09Z"
        },
        {
            "id": 161851,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.5,
            "comments": "This was fun",
            "spent_on": "2023-01-05",
            "created_on": "2023-01-05T17:37:40Z",
            "updated_on": "2023-01-05T17:37:40Z"
        },
        {
            "id": 161850,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18509
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.57,
            "comments": "This was fun",
            "spent_on": "2023-01-05",
            "created_on": "2023-01-05T17:37:01Z",
            "updated_on": "2023-01-05T17:37:01Z"
        },
        {
            "id": 161849,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 18609
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.47,
            "comments": "This was fun",
            "spent_on": "2023-01-05",
            "created_on": "2023-01-05T17:36:36Z",
            "updated_on": "2023-01-05T17:36:36Z"
        },
        {
            "id": 162165,
            "project": {
                "id": 138,
                "name": "Renuo Investments"
            },
            "issue": {
                "id": 5000
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.22,
            "comments": "This was fun",
            "spent_on": "2023-01-02",
            "created_on": "2023-01-10T18:09:30Z",
            "updated_on": "2023-01-10T18:09:30Z"
        },
        {
            "id": 161451,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19263
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.17,
            "comments": "This was fun",
            "spent_on": "2022-12-23",
            "created_on": "2022-12-23T16:26:45Z",
            "updated_on": "2022-12-23T16:26:45Z"
        },
        {
            "id": 161450,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19263
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.67,
            "comments": " This was fun",
            "spent_on": "2022-12-23",
            "created_on": "2022-12-23T16:22:42Z",
            "updated_on": "2022-12-23T16:22:42Z"
        },
        {
            "id": 161416,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19263
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.75,
            "comments": "This was fun",
            "spent_on": "2022-12-23",
            "created_on": "2022-12-23T10:45:34Z",
            "updated_on": "2022-12-23T10:45:34Z"
        },
        {
            "id": 161373,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19263
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.54,
            "comments": " This was fun",
            "spent_on": "2022-12-22",
            "created_on": "2022-12-22T17:02:16Z",
            "updated_on": "2022-12-22T17:02:16Z"
        },
        {
            "id": 161351,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19263
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 5.33,
            "comments": "This was fun",
            "spent_on": "2022-12-22",
            "created_on": "2022-12-22T15:31:11Z",
            "updated_on": "2022-12-22T15:31:11Z"
        },
        {
            "id": 161287,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19263
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 0.52,
            "comments": "This was fun",
            "spent_on": "2022-12-21",
            "created_on": "2022-12-21T20:10:40Z",
            "updated_on": "2022-12-21T20:10:40Z"
        },
        {
            "id": 161286,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19263
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 3.33,
            "comments": "This was fun",
            "spent_on": "2022-12-21",
            "created_on": "2022-12-21T20:05:28Z",
            "updated_on": "2022-12-21T20:05:28Z"
        },
        {
            "id": 161228,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19263
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.33,
            "comments": " This was fun",
            "spent_on": "2022-12-21",
            "created_on": "2022-12-21T12:40:50Z",
            "updated_on": "2022-12-21T12:40:50Z"
        },
        {
            "id": 161205,
            "project": {
                "id": 311,
                "name": "renuo1"
            },
            "issue": {
                "id": 19263
            },
            "user": {
                "id": 148,
                "name": "Gianlorenzo Occhipinti"
            },
            "activity": {
                "id": 14,
                "name": "Entwicklung"
            },
            "hours": 1.75,
            "comments": "This was fun",
            "spent_on": "2022-12-21",
            "created_on": "2022-12-21T08:46:02Z",
            "updated_on": "2022-12-21T08:46:02Z"
        }
    ],
    "total_count": 238,
    "offset": 0,
    "limit": 100
}
""".data(using: .utf8)!
