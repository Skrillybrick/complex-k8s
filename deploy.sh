docker build -t skrillybrick/complex-client:latest -t skrillybrick/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t skrillybrick/complex-server:latest -t skrillybrick/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t skrillybrick/complex-worker:latest -t skrillybrick/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push skrillybrick/complex-client:latest
docker push skrillybrick/complex-server:latest
docker push skrillybrick/complex-worker:latest

docker push skrillybrick/complex-client:$SHA
docker push skrillybrick/complex-server:$SHA
docker push skrillybrick/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skrillybrick/complex-server:$SHA
kubectl set image deployments/client-deployment client=skrillybrick/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=skrillybrick/complex-worker:$SHA