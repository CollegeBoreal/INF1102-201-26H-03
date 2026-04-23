# Setup

## :a: Class - INF1102-201-26H-03 - Programmation de systèmes

```
https://${LMS_URL}/course/view.php?id=3
```

## :b: Assignments for:

- [ ] courseids[0]=3

```json
{
  "id": 8,               // Assignment ID
  "cmid": 12,            // Rubric Definition CMID
  "name": "4.CRON-TASK"  // Assignment name
}
```

- [ ] Retrieve all assignments from LMS

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
<details><summary>📑</summary>

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
{
  "id": 20,
  "cmid": 24,
  "name": "5.BATCH"
}
{
  "id": 21,
  "cmid": 25,
  "name": "6.PWSH"
}
{
  "id": 22,
  "cmid": 26,
  "name": "7.REGEX"
}
{
  "id": 23,
  "cmid": 27,
  "name": "8.Project"
}
{
  "id": 24,
  "cmid": 28,
  "name": "9.Ansible"
}
```

</details>
