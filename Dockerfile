# =========================
# Stage 1: Build with Maven
# =========================
FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# =========================
# Stage 2: Runtime Image
# =========================
FROM openjdk:17-jdk-slim
WORKDIR /app

COPY --from=build /app/target/app.war /app/app.war

ENV JAVA_OPTS="-Xms256m -Xmx512m \
  -XX:+UseContainerSupport \
  -XX:MaxRAMPercentage=75.0 \
  -XX:+ExitOnOutOfMemoryError"

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/app.war"]
