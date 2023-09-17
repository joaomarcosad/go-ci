# Use a imagem base do Go
FROM golang:1.21.0-alpine3.17 AS build

# Configure o diretório de trabalho
WORKDIR /app

# Copie o arquivo go.mod e go.sum para permitir a instalação das dependências
COPY go.mod go.sum ./

# Baixe as dependências
RUN go mod download

# Copie o código-fonte para o contêiner
COPY . .

# Compile o aplicativo
RUN go build -o math

# Use uma imagem menor como imagem final
FROM alpine:3.17

# Configure o diretório de trabalho no segundo estágio
WORKDIR /app

# Copie o executável compilado do primeiro estágio
COPY --from=build /app/math .

# Defina as variáveis de ambiente apropriadas, se necessário

# Execute o aplicativo
CMD ["./math"]