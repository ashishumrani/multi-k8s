docker build -t ashishumrani/multi-client:latest -t ashishumrani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ashishumrani/multi-server:latest -t ashishumrani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ashishumrani/multi-worker:latest -t ashishumrani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ashishumrani/multi-client:latest
docker push ashishumrani/multi-server:latest
docker push ashishumrani/multi-worker:latest

docker push ashishumrani/multi-client:$SHA
docker push ashishumrani/multi-server:$SHA
docker push ashishumrani/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ashishumrani/multi-client:$SHA
kubectl set image deployments/server-deployment server=ashishumrani/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ashishumrani/multi-worker:$SHA