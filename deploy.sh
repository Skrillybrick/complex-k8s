docker build -t skrillybrick/complex-client:latest -t skrillybrick/complex-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t skrillybrick/complex-server:latest -t skrillybrick/complex-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t skrillybrick/complex-worker:latest -t skrillybrick/complex-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push skrillybrick/complex-client:latest
docker push skrillybrick/complex-server:latest
docker push skrillybrick/complex-worker:latest
docker push skrillybrick/complex-client:$GIT_SHA
docker push skrillybrick/complex-server:$GIT_SHA
docker push skrillybrick/complex-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skrillybrick/complex-server:$GIT_SHA
kubectl set image deployments/client-deployment server=skrillybrick/complex-client:$GIT_SHA
kubectl set image deployments/worker-deployment server=skrillybrick/complex-worker:$GIT_SHA