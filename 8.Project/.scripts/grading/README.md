# Setup

## :a: LMS Assignment ID = 23

```
https://${LMS_URL}/mod/assign/view.php?id=23
```

```json
{
  "id": 23,            // Assignment ID
  "cmid": 27,          // Rubric Definition CMID
  "name": "8.Project"  // Assignment name
}
```

## :b: Rubric Definition for

- [ ] cmids[0]=27

- [ ] Retrieve all rubric definitions from LMS


```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=27" \
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
      "cmid": 27,
      "contextid": 480,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 22,
          "method": "rubric",
          "name": "🅰️ Présence",
          "description": "",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1776971276,
          "usercreated": 3,
          "timemodified": 1776995538,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 109,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 251,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 252,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 253,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 110,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 254,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 255,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 111,
                "sortorder": 3,
                "description": "🚀 analyse.py",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 256,
                    "score": 0,
                    "definition": "❔",
                    "definitionformat": 1
                  },
                  {
                    "id": 257,
                    "score": 1,
                    "definition": "‼️",
                    "definitionformat": 1
                  },
                  {
                    "id": 284,
                    "score": 2,
                    "definition": "🚀",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 113,
                "sortorder": 4,
                "description": "🧾 RAPPORT",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 260,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 261,
                    "score": 1,
                    "definition": "🧾",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 112,
                "sortorder": 5,
                "description": "✍️ Sgn",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 258,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 259,
                    "score": 1,
                    "definition": "✍️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 114,
                "sortorder": 6,
                "description": "🖼️ Figures",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 262,
                    "score": 0,
                    "definition": "0️⃣",
                    "definitionformat": 1
                  },
                  {
                    "id": 263,
                    "score": 1,
                    "definition": "1️⃣",
                    "definitionformat": 1
                  },
                  {
                    "id": 264,
                    "score": 2,
                    "definition": "*️⃣",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 115,
                "sortorder": 7,
                "description": "analyse.ps1",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 265,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 266,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 116,
                "sortorder": 8,
                "description": "rapport.txt",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 267,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 268,
                    "score": 1,
                    "definition": "✔️",
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
