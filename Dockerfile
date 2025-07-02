FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Isso aproveita o cache de camadas do Docker. A instalação das dependências
# só será refeita se o arquivo requirements.txt for alterado.
COPY requirements.txt .

# Instala as dependências do projeto.
# Usar --no-cache-dir ajuda a manter o tamanho da imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Copia todos os arquivos do projeto para o diretório de trabalho no contêiner.
COPY . .

# Expõe a porta em que a aplicação FastAPI estará escutando.
EXPOSE 8000

# Comando para iniciar a aplicação uvicorn quando o contêiner for executado.
# O host 0.0.0.0 é necessário para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]