docker build -t lelouchdocker/multi-client:latest -t lelouchdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lelouchdocker/multi-server:latest -t lelouchdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lelouchdocker/multi-worker:latest -t lelouchdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lelouchdocker/multi-client:latest
docker push lelouchdocker/multi-server:latest
docker push lelouchdocker/multi-worker:latest

docker push lelouchdocker/multi-client:$SHA
docker push lelouchdocker/multi-server:$SHA
docker push lelouchdocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lelouchdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=lelouchdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lelouchdocker/multi-worker:$SHA