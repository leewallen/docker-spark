package app;

import org.apache.spark.api.java.function.FilterFunction;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.SparkSession;

import java.io.File;
import java.util.Locale;

public class SimpleApp {
  public static void main(String[] args) {
    SimpleApp app = new SimpleApp();
    String targetFile = ""; // Should be some file on your system
    if (args.length > 0) {
      targetFile = args[0];
    } else {
      ClassLoader classLoader = app.getClass().getClassLoader();
      File file = new File(classLoader.getResource("test.txt").getFile());
      targetFile = file.getAbsolutePath();
      System.out.printf("Using %s\n", targetFile);
    }

    SparkSession spark = SparkSession.builder().appName("Simple Application").getOrCreate();
    Dataset<String> logData = spark.read().textFile(targetFile).cache();

    System.out.printf("Lines with a: %s\nLines with b: %s\nLines with java: %s\n",
      app.getCounts(logData, "a"),
      app.getCounts(logData, "b"),
      app.getCounts(logData, "java")
    );

    spark.stop();

  }

  public long getCounts(Dataset<String> logData, String searchText) {
    return logData.filter((FilterFunction<String>) s ->
            s.toLowerCase().contains(searchText.toLowerCase())).count();
  }
}

