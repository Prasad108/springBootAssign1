package arquillian;

import java.io.File;

import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.container.test.api.RunAsClient;
import org.jboss.arquillian.core.api.annotation.Inject;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.arquillian.test.api.ArquillianResource;
import org.jboss.shrinkwrap.api.Archive;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.shrinkwrap.api.importer.ZipImporter;
import org.jboss.shrinkwrap.api.spec.WebArchive;
import org.jboss.shrinkwrap.resolver.api.maven.Maven;
import org.jboss.shrinkwrap.resolver.api.maven.ScopeType;
import org.json.JSONObject;
//import org.jboss.shrinkwrap.resolver.api.maven.PomEquippedResolveStage;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;

import com.app.pojo.Person;

import io.restassured.http.ContentType;

import static io.restassured.RestAssured.*;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertEquals;

import io.restassured.RestAssured;
import io.restassured.parsing.Parser;
import io.restassured.response.Response;

@RunWith(Arquillian.class)
public class GreeterTest {

	/*
	 * @Inject Greeter greeter;
	 */

	String message = "Robert";
	Person person=new Person();

	/*
	 * @Deployment public static Archive createTestArchive() { final String
	 * WEBAPP_SRC = "src/main/webapp"; File[] files
	 * =Maven.configureResolver().withMavenCentralRepo(false).loadPomFromFile(
	 * "pom.xml")
	 * .importRuntimeDependencies().resolve().withTransitivity().asFile(); return
	 * ShrinkWrap .create(WebArchive.class, "testArquillian.war") .addPackages(true,
	 * "com.app") .addAsWebResource(new File(WEBAPP_SRC,
	 * "WEB-INF/view/addPerson.jsp")) .addAsWebResource(new File(WEBAPP_SRC,
	 * "WEB-INF/view/showPerson.jsp")) // .addAsLibraries(files)
	 * .addAsWebResource(new File(WEBAPP_SRC, "WEB-INF/view/index.jsp")); }
	 */

	@Deployment
	public static WebArchive createDeployment() {

		return ShrinkWrap.create(ZipImporter.class, "deployed.war")
				.importFrom(new File("target/demo-2.0.0.BUILD-SNAPSHOT.war")).as(WebArchive.class);

	}

	@Test
	@RunAsClient
	public void testGetAllPerson4() {

		RestAssured.registerParser("text/plain", Parser.JSON);

		given().contentType(ContentType.JSON).

				when().get("http://localhost:8080/deployed/showPerson").then().assertThat().statusCode(200);

	}

	@Test
	@RunAsClient
	public void testSaveAndDeletePerson() {

		RestAssured.registerParser("text/plain", Parser.JSON);
		 person = new Person("Prasad", "Ashok", "Dukale", "Dance");
		 

		given().contentType(ContentType.JSON).body(person).when().post("http://localhost:8080/deployed/SavePerson")
				.then().assertThat().statusCode(200);
		
		System.out.println("$$$$$$$$$$$$$$$$$$$$$ Person is saved "+person+"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		given().contentType(ContentType.JSON).when().post("http://localhost:8080/deployed/DeletePerson/12")
		.then().assertThat().statusCode(200);

	}
	
	@Test
	@RunAsClient
	public void GetPerson() {

		RestAssured.registerParser("text/plain", Parser.JSON);
		given().contentType(ContentType.JSON).when().post("http://localhost:8080/deployed/GetPerson/1")
				.then().assertThat().statusCode(200);

	}

	/*@SuppressWarnings("deprecation")
	@Test
	@RunAsClient
	public void testGetPerson() {

		RestAssured.registerParser("text/plain", Parser.JSON);
		given().parameters("id", 11).when().post("http://localhost:8080/deployed/GetPerson").then().assertThat()
				.statusCode(200);
				// spec(checkStatusCodeAndContentType).
				//and().body("fname[0]", equalTo("Anil")).body("mname[0]", equalTo("Balasaheb"));

	}*/
}

// .body("fname", equalTo("Prasad"));

/*
 * JSONObject JSONResponseBody = new JSONObject(response.asString());
 * 
 * //Get the desired value of a parameter String result =
 * JSONResponseBody.getString({key});
 */
/*
 * String body = response.getBody().asString();
 * 
 * String test=response.jsonPath().getString("fname[0]");
 * System.out.println(test);
 */
