# Setup

## :a: LMS Assignment ID = 20

```
https://${LMS_URL}/mod/assign/view.php?id=20
```

```json
{
  "id": 20,             // Assignment ID
  "cmid": 24,           // Rubric Definition CMID
  "name": "5.BATCH"     // Assignment name
}
```

## :b: Rubric Definition for

- [ ] cmids[0]=24

- [ ] Retrieve all rubric definitions from LMS

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=24" \
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
      "cmid": 24,
      "contextid": 477,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 19,
          "method": "rubric",
          "name": "🅰️ Présence",
          "description": "",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1776970942,
          "usercreated": 3,
          "timemodified": 1776971031,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 96,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 222,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 223,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 224,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 97,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 225,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 226,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 98,
                "sortorder": 3,
                "description": "script_gestion.sh",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 227,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 228,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 99,
                "sortorder": 4,
                "description": "🎓 SSH",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 229,
                    "score": 0,
                    "definition": "💥",
                    "definitionformat": 1
                  },
                  {
                    "id": 230,
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