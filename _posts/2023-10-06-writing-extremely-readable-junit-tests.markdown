---
layout: post
title:  "Writing Extremely Readable JUnit Tests in Java"
date:   2023-10-06 20:00:00 +0000
categories: [Java]
---
![programmer](/assets/images/programmer.webp){:class="img-responsive"}

<span class="underline">Imagine:</span> you've written a JUnit test for a Java class and followed several best practices:  
* Divide the test into a <span class="highlighter-rouge">setup, execute and verify </span> phase.  
* Choose <span class="highlighter-rouge">perfect names</span> for methods and variables.  
* <span class="highlighter-rouge">Refactored</span> the code to make it more testable.  
* Applied <span class="highlighter-rouge">separation of concerns</span> and only test one thing in a unit test.  
* Use <span class="highlighter-rouge">mocks</span> to limit the scope of the test.  

And yet, when you return after a couple of weeks you find the test <span class="underline">unreadable and need to spend several minutes trying to understand it</span>.

In this case consider creating a <span class="underline">micro DSL</span> (Domain Specific Language) for your unit test.  The DSL needs to use common words and verbs defined as methods which can be <span class="underline">chained</span> to create a readable sentence which describes a case in the unit test. 

The general form of such a micro DSL will look like:

{% highlight java %}
when().parameter1HasValue(x).andParameter2HasValue(y).then().expectedOutcomeIs(z)
{% endhighlight %}


Creating chainable words and verbs can be achieved by creating private methods in the test class that <span class="highlighter-rouge">return 'this'</span>.

#### Example

The provided example is written in <span class="underline">Java17</span> and <span class="underline">JUnit5</span>.  The maven compiler plugin is configured to compile towards Java17 an junit-jupiter is added as dependency in the <span class="underline">pom.xml</span>.

<span class="underline">Note:</span> The micro DSL approach for writing JUnit tests can be applied to other Java versions and testing frameworks as well.

{% highlight xml %}
<build>
  <plugins>
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-compiler-plugin</artifactId>
      <version>3.11.0</version>
      <configuration>
        <release>17</release>
      </configuration>
    </plugin>
  </plugins>
</build>

<dependencies>
  <dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>5.10.0</version>
      <scope>test</scope>
  </dependency>
</dependencies>
{% endhighlight %}

<span class="underline">Use case:</span> Logic needs to be created for a plant watering system that decides if plants needs water based on the current time and humidity:

>  Plants should only be watered after 7PM and only if the humidity has dropped below 50%.  

The logic is contained in a class <span class="highlighter-rouge">PlantWateringSystem</span> on which a method can be invoked: <span class="highlighter-rouge">boolean plantsNeedWater()</span> which indicates if plants need to be watered.

To keep things simple the current time and humidity can be set on the system with setters <span class="highlighter-rouge">setHour(int)</span> and <span class="highlighter-rouge">setHumidity(float)</span>

Edge cases are tested with 2 tests:
* <span class="underline">test 1</span> will verify if plants are only watered after 7PM.
* <span class="underline">test 2</span> will verify if plants are only waterd if the humidity drops below 50%.


{% highlight java %}
package org.maxxq.junit.training;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

public class PlantWateringSystemTest {
	private PlantWateringSystem system;
	private boolean plantsAreWatered;

	@Test
	public void waterPlantsOnOrAfter7PM() {
		when().hourIs(18).andHumidityIs(0).then().plantsAreWatered(false);
		when().hourIs(19).andHumidityIs(0).then().plantsAreWatered(true);
		when().hourIs(20).andHumidityIs(0).then().plantsAreWatered(true);
	}

	@Test
	public void waterPlantsWhenHumidityLessThen50Percent() {
		when().hourIs(20).andHumidityIs(0.51F).then().plantsAreWatered(false);
		when().hourIs(20).andHumidityIs(0.50F).then().plantsAreWatered(false);
		when().hourIs(20).andHumidityIs(0.49F).then().plantsAreWatered(true);
	}

	private PlantWateringSystemTest when() {
		system = new PlantWateringSystem();
		return this;
	}

	private PlantWateringSystemTest hourIs(int hour) {
		this.system.setHour(hour);
		return this;
	}

	private PlantWateringSystemTest andHumidityIs(float humidity) {
		this.system.setHumidity(humidity);
		return this;
	}

	private PlantWateringSystemTest then() {
		this.plantsAreWatered = system.plantsNeedWater();
		return this;
	}

	private PlantWateringSystemTest plantsAreWatered(boolean expected) {
		assertEquals(expected, plantsAreWatered);
		return this;
	}
}
{% endhighlight %}

Each test starts with <span class="highlighter-rouge">when()</span>, the implementation of this method can be used to reset the system.  In case mocks are used this is the time to recreate them to ensure no state is left from a previous test.  A new instance of PlantWateringSystem is created to ensure no state is left from a previous test.

Methods <span class="highlighter-rouge">hourIs()</span>, <span class="highlighter-rouge">andHumidityIs()</span> are setting the current values for the hour and humidity and store them in the global instance of PlantWateringSystem. 

The method <span class="highlighter-rouge">then()</span> will execute the method <span class="highlighter-rouge">plantsNeedWater()</span>and store the result as a global variable <span class="highlighter-rouge">plantsAreWatered</span>.

The method <span class="highlighter-rouge">plantsAreWatered(boolean)</span> will verify if the result corresponds to the expected value.  If desired multiple methods can be crafted to check for a correct outcome.

### Considerations when to use and not to use micro DSL in JUnit tests

<span class="underline">Not all code should be tested with micro DSL in JUnit tests.</span>  
Use it in cases where:
* The logic depends on <span class="underline">multiple input criteria</span>.
* When <span class="underline">multiple output states</span> need to be tested.  
* A multitude of <span class="underline">edge cases</span> need to be tested.
