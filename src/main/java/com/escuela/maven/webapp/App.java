package com.escuela.maven.webapp;
																																																																																									       import spark.Request;
																																																																																									       import spark.Response;
																																																																																									       import static spark.Spark.*;

																																																																																									       /**
																																																																																									        * Hello world!
																																																																																										 *
																																																																																										  */
																																																																																										  public class App
																																																																																										  {
																																																																																											          public static void main(String... args){
																																																																																												          port(4568);
																																																																																													          get("hello", (req,res) -> "Hello Deploy CDK AWS!");
																																																																																														                                          }
																																																																																																	  }
