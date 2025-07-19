FROM python:3.11-slim

# Instalar dependencias del sistema necesarias para TA-Lib
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    git \
    libffi-dev \
    libssl-dev \
    libta-lib0 \
    libta-lib-dev \
    && rm -rf /var/lib/apt/lists/*

# Crear carpeta de trabajo
WORKDIR /app

# Copiar archivos del proyecto
COPY . /app

# Instalar dependencias Python
RUN pip install --upgrade pip && pip install -r requirements.txt

# Exponer el puerto 8000
EXPOSE 8000

# Comando de inicio
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
