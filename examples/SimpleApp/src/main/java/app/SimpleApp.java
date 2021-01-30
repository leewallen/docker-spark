package app;

import org.apache.spark.api.java.function.FilterFunction;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.SparkSession;

import java.io.FileNotFoundException;
import java.util.Locale;

public class SimpleApp {
  public static void main(String[] args) {
    String targetFile = ""; // Should be some file on your system
    if (args.length > 0) {
      targetFile = args[0];
    } else {
      FileNotFoundException exception = new FileNotFoundException("Path to data.txt file was not provided.");
      throw new RuntimeException(exception);
    }

    SparkSession spark = SparkSession.builder().appName("Simple Application").getOrCreate();
    Dataset<String> logData = spark.read().textFile(targetFile);

    System.out.printf("%n%n\tLines with a   : %s%n\tLines with b   : %s%n\tLines with java: %s%n%n%n",
      logData.filter((FilterFunction<String>) s -> s.toLowerCase().contains("a")).count(),
      logData.filter((FilterFunction<String>) s -> s.toLowerCase().contains("b")).count(),
      logData.filter((FilterFunction<String>) s -> s.toLowerCase().contains("java")).count()
    );

    spark.stop();
  }
}

