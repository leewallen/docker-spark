package app;

import org.apache.spark.api.java.function.*;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Encoders;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

import java.io.FileNotFoundException;
import java.io.File;
import java.util.*;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.*;

public class SimpleApp {
  public static void main(String[] args) {
    SimpleApp app = new SimpleApp();
    String targetFile = ""; // Should be some file on your system
    if (args.length > 0) {
      targetFile = args[0];
    } else {
      FileNotFoundException exception = new FileNotFoundException("Path to data.txt file was not provided.");
      throw new RuntimeException(exception);
    }

    SparkSession spark = SparkSession.builder().appName("Simple Application").getOrCreate();
    Dataset<String> logData = spark.read().textFile(targetFile);

    System.out.printf("Lines with a   : %s\nLines with b   : %s\nLines with java: %s\n",
            logData.filter((FilterFunction<String>) s -> s.contains("a")).count(),
            logData.filter((FilterFunction<String>) s -> s.contains("b")).count(),
            logData.filter((FilterFunction<String>) s -> s.contains("java")).count()
    );

    spark.stop();
  }
}

