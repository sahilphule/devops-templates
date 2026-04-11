pip install fastapi uvicorn pydantic
pip install fastapi[standard]

fastapi run main.py --reload

# start uvicorn server in background
nohup uvicorn main:app --host 0.0.0.0 --port <port> &

# start uvicorn server in background and write logs to custom file
nohup uvicorn main:app --host 0.0.0.0 --port <port> > fastapi.log 2>&1 &

# get uvicorn running processes
ps aux | grep uvicorn

# kill uvicorn process
kill <pid>

# force kill uvicorn process
kill -9 <pid>

# kill all uvicorn processes
pkill -f uvicorn
