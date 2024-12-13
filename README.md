#RUN

```sh
chmod +x depploy.sh
bash deploy.sh
```

```sh
http://localhost:5050/mikrotik/command?host=127.0.0.xxx&port=28728&user=jhon&password=dho&command=/ppp/active/print

```

```sh
Header : Bearer api_key
```

```sh
curl -X GET "http://localhost:5050/mikrotik/command?host=10.11.0.2&port=28728&user=xxx&password=xxxx&command=/ppp/active/print" \
-H "Authorization: Bearer YOUR_API_KEY"
```
