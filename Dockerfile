FROM python:3.13-slim

WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Install dependencies first for better Docker layer caching
COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --no-install-project

# Copy application code
COPY . .

# Install the project
RUN uv sync --frozen

EXPOSE 8000

CMD ["uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
