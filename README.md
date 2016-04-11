current location: https://stormy-earth-63942.herokuapp.com
# Image Crawler
Image Crawler is an API for crawling URLs and returning

## Jobs
#### POST /jobs
Use to create a crawling request

Request
```bash
$ curl -X POST -H 'Content-Type: application/json' -d '{"urls":["https://www.statuspage.io"]}' https://stormy-earth-63942.herokuapp.com/jobs
```

Response 202 (application/json)
```json
{
  'id': 'UNIQUE_JOB_ID'
}
```
#### GET /jobs/UNIQUE_JOB_ID/status/
Use to retrieve status of a created job

Request
```bash
$ curl  https://stormy-earth-63942.herokuapp.com/jobs/UNIQUE_JOB_ID/status
```

Response 200 (application/json)
```json
{
    "id":UNIQUE_JOB_ID,
    "status": {
        "completed":1,
        "inprogress":0
    }
}
```

#### GET /jobs/UNIQUE_JOB_ID/results/
Use to retrieve results for job

Request
```bash
$ curl  https://stormy-earth-63942.herokuapp.com/jobs/UNIQUE_JOB_ID/results
```

Response 200 (application/json)
```json
{
    "id":UNIQUE_JOB_ID,
    "results": {
        "https://www.statuspage.io": [
             "https://www.statuspage.io/image1.png",
             "https://www.statuspage.io/image2.jpg"
        ]
    }
}
```


