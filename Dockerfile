FROM openjdk:8 as builder
RUN apt-get update -y && apt-get install maven -y 
WORKDIR /mnt
COPY student-ui /mnt/student-ui
WORKDIR /mnt/student-ui
RUN mvn clean package

FROM tomcat
COPY --from=builder /mnt/student-ui/target/*.war webapps/