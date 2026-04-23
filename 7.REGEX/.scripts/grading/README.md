# Setup

## :a: LMS Assignment ID = 22

```
https://${LMS_URL}/mod/assign/view.php?id=22
```

```json
{
  "id": 22,             // Assignment ID
  "cmid": 26,           // Rubric Definition CMID
  "name": "7.REGEX"      // Assignment name
}
```

## :b: Rubric Definition for

- [ ] cmids[0]=26

- [ ] Retrieve all rubric definitions from LMS

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=26" \
-d "areaname=submissions" | jq .
```
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  2397    0  2261  100   136   3849    231 --:--:-- --:--:-- --:--:--  4076
```
<details><summary>📑</summary>

```json
{
  "areas": [
    {
      "cmid": 26,
      "contextid": 479,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 21,
          "method": "rubric",
          "name": "🅰️ Présence",
          "description": "",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1776971169,
          "usercreated": 3,
          "timemodified": 1776971260,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 104,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 240,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 241,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 242,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 105,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 243,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 244,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 106,
                "sortorder": 3,
                "description": "analyse_nginx.ps1",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 245,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 246,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 108,
                "sortorder": 4,
                "description": "analyse_nginx.py",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 249,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 250,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 107,
                "sortorder": 5,
                "description": "🎓 SSH",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 247,
                    "score": 0,
                    "definition": "💥",
                    "definitionformat": 1
                  },
                  {
                    "id": 248,
                    "score": 1,
                    "definition": "🔗",
                    "definitionformat": 1
                  }
                ]
              }
            ]
          }
        }
      ]
    }
  ],
  "warnings": []
}
```

</details>