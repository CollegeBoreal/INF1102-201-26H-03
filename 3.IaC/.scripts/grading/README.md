# Setup

## :zero: Class - INF1102-201-26H-03 - Programmation de systèmes

- [ ] courseids[0]=3

```
https://${LMS_URL}/course/view.php?id=3
```

## :one: LMS Assignment ID = 7

```
https://${LMS_URL}/mod/assign/view.php?id=7
```

- [ ] "id": 7 :point_left: Take this as the assignment number !!!
- [ ] "cmid": 11

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
  "id": 7,
  "cmid": 11,
  "name": "3.IaC"
}
{
  "id": 8,
  "cmid": 12,
  "name": "4.CRON-TASK"
}
```

## :two: Rubric Definition CMID = 11

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=11" \
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
      "cmid": 11,
      "contextid": 446,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 6,
          "method": "rubric",
          "name": "🅰️ Présence",
          "description": "",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1776795179,
          "usercreated": 3,
          "timemodified": 1776797648,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 17,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 40,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 41,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 42,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 18,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 43,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 44,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 19,
                "sortorder": 3,
                "description": "main.tf",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 45,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 46,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 20,
                "sortorder": 4,
                "description": "VM",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 47,
                    "score": 0,
                    "definition": "🔴 ",
                    "definitionformat": 1
                  },
                  {
                    "id": 48,
                    "score": 1,
                    "definition": "🟢",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 21,
                "sortorder": 5,
                "description": "🎓 SSH",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 49,
                    "score": 0,
                    "definition": "💥",
                    "definitionformat": 1
                  },
                  {
                    "id": 50,
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
