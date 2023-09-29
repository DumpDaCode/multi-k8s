docker build -t dumpdacode/multi-client:latest -t dumpdacode/multi-client:$SHA -f ./client/Dockerfile ./client
docker push dumpdacode/multi-client:latest
docker push dumpdacode/multi-client:$SHA

docker build -t dumpdacode/multi-server:latest -t dumpdacode/multi-server:$SHA -f ./server/Dockerfile ./server
docker push dumpdacode/multi-server:latest
docker push dumpdacode/multi-server:$SHA

docker build -t dumpdacode/multi-worker:latest -t dumpdacode/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dumpdacode/multi-worker:latest
docker push dumpdacode/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=dumpdacode/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dumpdacode/multi-worker:$SHA
kubectl set image deployments/client-deployment client=dumpdacode/multi-client:$SHA