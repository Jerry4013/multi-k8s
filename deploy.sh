docker build -t jerry4013/multi-client:latest -t jerry4013/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jerry4013/multi-server:latest -t jerry4013/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jerry4013/multi-worker:latest -t jerry4013/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jerry4013/multi-client:latest
docker push jerry4013/multi-server:latest
docker push jerry4013/multi-worker:latest

docker push jerry4013/multi-client:$SHA
docker push jerry4013/multi-server:$SHA
docker push jerry4013/multi-worker:$SHA

kubectl apply -f k8s
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jerry4013/multi-server:$SHA
kubectl set image deployments/client-deployment client=jerry4013/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jerry4013/multi-worker:$SHA
