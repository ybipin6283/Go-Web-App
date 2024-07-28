# as base is the alias of the golang
FROM golang:1.22.5 as base 
# all the command that will wirte execute in the work directory
WORKDIR /app
# the dependecy of go application are stored in go.mod file
COPY go.mod .
# run the go.mod dependency file 
RUN go mod download
# this will run locally and artifact/ binary called main will created in docker image.
COPY . .

RUN go build -o main .

# final stage -Destroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD [ "./main" ]