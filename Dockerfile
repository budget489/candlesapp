FROM python:3.10-slim

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    git \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Descargar y compilar TA-Lib manualmente
RUN curl -L https://sourceforge.net/projects/ta-lib/files/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz/download -o ta-lib-0.4.0-src.tar.gz && \
    tar -xvzf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib && \
    ./configure --prefix=/usr && \
    make && make install

# Crear el directorio de trabajo
WORKDIR /app

# Copiar los archivos
COPY . .

# Instalar dependencias Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Exponer el puerto (opcional en Render)
EXPOSE 8000

# Comando para iniciar la app
CMD ["python", "app.py"]
