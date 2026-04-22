# Setup

## :zero: Class - INF1102-201-26H-03 - Programmation de systèmes

- [ ] courseids[0]=3

```
https://${LMS_URL}/course/view.php?id=3
```

## :one: LMS Assignment ID = 9

```
https://${LMS_URL}/mod/assign/view.php?id=7
```

- [ ] "id": 9 :point_left: Take this as the assignment number !!!
- [ ] "cmid": 13

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=mod_assign_get_assignments" \
-d "moodlewsrestformat=json" \
-d "courseids[0]=3" | jq '.courses[].assignments[] | {id, cmid, name}'
```
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1704    0  1587  100   117   2463    181 --:--:-- --:--:-- --:--:--  2645
```
```json
{
  "id": 8,
  "cmid": 12,
  "name": "4.CRON-TASK"
}
{
  "id": 9,
  "cmid": 13,
  "name": "3.IaC"
}
```

## :two: Rubric Definition CMID = 13

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=13" \
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
      "cmid": 13,
      "contextid": 448,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 8,
          "method": "rubric",
          "name": "Présence",
          "description": "",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1776801503,
          "usercreated": 3,
          "timemodified": 1776801503,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 26,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 60,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 61,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 62,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 27,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 63,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 64,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 28,
                "sortorder": 3,
                "description": "main.tf",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 65,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 66,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 29,
                "sortorder": 4,
                "description": "VM",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 67,
                    "score": 0,
                    "definition": "🔴",
                    "definitionformat": 1
                  },
                  {
                    "id": 68,
                    "score": 1,
                    "definition": "🟢",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 30,
                "sortorder": 5,
                "description": "SSH",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 69,
                    "score": 0,
                    "definition": "💥",
                    "definitionformat": 1
                  },
                  {
                    "id": 70,
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
