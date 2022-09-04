# Rails Engine

<ul>
<li><b>Rails Engine</b> is a <b>Rails</b> application that works within a service-oriented architecture to expose data through an <b>API</b> that the front-end team can consume.</li>
<li>Additional Functionality:</li><ul>
<li>Uses serializers to format <b>JSON</b> responses</li>
<li>Tests <b>API</b> exposure</li>
<li>Uses <b>SQL</b> and <b>ActiveRecord</b> to gather data</li></ul>
</ul>

<!-- TABLE OF CONTENTS -->
<h2 id="table-of-contents"> :book: Table of Contents</h2>

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#techical-requirements"> ➤ Technical Requirements</a></li>
    <li><a href="#project-files-description"> ➤ Project Files Description</a></li>
    <li><a href="#db-schema"> ➤ Database Schema</a></li>
    <li><a href="#getting-started"> ➤ Getting Started</a></li>
    <li><a href="#scenario1"> ➤ Scenario 1: Create a New User </a></li>
    <li><a href="#scenario2"> ➤ Scenario 2: Discover Movies </a></li>
    <li><a href="#scenario3"> ➤ Scenario 3: Create a Viewing Party  </a></li>
    <li><a href="#scenario4"> ➤ Scenario 4: View User Dashboard</a></li>
    <li><a href="#credits"> ➤ Credits</a></li>
  </ol>
</details>

<!-- TECHNICAL REQUIREMENTS -->
<h2 id="techical-requirements"> 💻 Technical Requirements</h2>
<ul>
  <li>Ruby 2.7.4</li>
  <li>Rails 5.2.6</li>
  <li>RSpec-Rails 4.0.1</li>
  <li>JSON API Serializer</li>
  <li>Factory Bot</li>
  <li>Faker</li>
  <li>SimpleCov</li>
  <li>Postman</li>
  </ul>
  <p><i>Installation instructions found in</i> <a href="#getting-started"> ➤ Getting Started</a></p>
   
<!-- PROJECT FILES DESCRIPTION -->
<h2 id="project-files-description"> :floppy_disk: Project Files Description</h2>

<ul>
  <li><b>app/controllers/api/v1</li></b>
  <ol>
  <li>Contains several controllers responsible for rendering <b>JSON</b> responses and status codes.</li></ol>
  <li><b>app/serializers</b></li><ol>
  <li>Serializers for <i>Item</i> and <i>Merchant</i> objects.</li>
  <li>Uses the <b>JSON API Serializer Gem</b> to format responses.</li></ol>
   <li><b>app/models</b>
    <ol><li>Contains models for with added associations and validations</li></ol>
  <li><b>spec/factories</b></li><ol>
  <li>Defines <b>FactoryBot</b> objects instantiated in test suite</li></ol>
  <li><b>app/requests</b><ol>
  <li>Testing suite for API calls to endpoints</li></ol>
  <li><b>app/models</b></li><ol>
  <li>Model tests for database objects invoked in API calls</i></li></ol>
</ul>

<h3>Some other supporting files</h3>
<ul><li><b>app/coverage</b><ol>
  <li>Shows SimpleCov coverage report</li>
</ul>

<!-- DATABASE SCHEMA -->
<h2 id="db-schema"> :desktop_computer: Database Schema</h2>

<img width="750" alt="Screen Shot 2022-09-04 at 12 53 40 PM" src="https://user-images.githubusercontent.com/95776577/188324699-55143081-0395-47b6-8663-ef4e418308c5.png">


<!-- GETTING STARTED -->
<h2 id="getting-started"> :book: Getting Started</h2>

<p><b>1. </b> Create a new directory on your computer where you'd like the program to live.</p>
<pre><code>$ mkdir /your_folder/rails-engine</code></pre>

<p><b>2. </b> Navigate into the recently created directory.</p>
<pre><code>$ cd /your_folder/rails-engine</code></pre>
<p><b>3. </b> Copy the repository by clicking on the code button on Github repo page (using SSH).</p>

![183747041-40f47875-442e-4008-8d00-8c45bf2731fe](https://user-images.githubusercontent.com/95776577/183752233-c9130b38-ce16-4b4c-aeb4-fdf0d0d4a137.png)

<p><b>4. </b> Clone the recently copied repository information into your currenty directory.</p>
<pre><code>$ git clone git@github.com:JohnSantosuosso/rails-engine.git</code></pre>

<p><b>5. </b> Open the repository in your preferred IDE.  If you are using VSCode, use the code command shown below:</p>
<pre><code>$ code .</code></pre>

<p><b>6. </b> Download Tests for Postman</a>.</p>
<ul><li><a href="https://backend.turing.edu/module3/projects/rails_engine_lite/RailsEngineSection1.postman_collection.json">Postman Testing Suite 1</a></li>
<li><a href="https://backend.turing.edu/module3/projects/rails_engine_lite/RailsEngineSection2.postman_collection.json">Postman Testing Suite 2</a></li>
<li>Click on each link to load it in your browser, then hit Cmd-S to save it to your system.</li></ul>

<p><b>6. </b> Import Postman tests</a>.</p>
<ul><li>In Postman, in the top left corner, click on the <b>Import</b> button, and use the file selector to locate the two files on your operating system.</li>
<li>Next, you’ll <b>confirm</b> the import. The test suite should display as a <b>Postman Collection v2.1</b> and import as a <i>Collection</i>. Click the <b>Import</b> button to continue.</li>
<li>Within your collections in Postman, you should see two collections– <b>Rails Engine Lite, Part 1</b>, and <b>Rails Engine Lite, Part 2</b>.</li></ul>

<p><b>6. </b> In your IDE, install dependencies found in Gemfile using your terminal</a>.</p>
<pre><code>$ bundle install</code></pre>

<p><b>10. </b> Run migrations and dump schema</p>
<pre><code>$ rake db:{drop,create,migrate,seed}</code></pre>
<pre><code>$ rails db:schema:dump</code></pre>

<p><b>10. </b> Run testing suite</p>
<pre><code>$ bundle exec rspec spec</code></pre>

<p><b>11. </b> Initiate the application on your local server</a>.</p>
<pre><code>$ rails s</code></pre>

<p><b>12. </b> Open your favorite web browser and enter the URL in the address bar:</p>
<pre><code>localhost:3000</code></pre>



<!-- SCENARIO1 -->
<h2 id="scenario1"> :small_orange_diamond: Scenario 1: Create a New User</h2>
<p>A new user can be created and stored in the database.  Validations exist to prevent multiple users registered with the same email address.</p>

![step 1-1](https://user-images.githubusercontent.com/95776577/188297760-5b9c7bd5-0b87-4dd6-ac7a-8fd708ff9215.gif)


<!-- SCENARIO2 -->
<h2 id="scenario2"> :small_orange_diamond: Scenario 2: Discover Movies </h2>
<p>A user can search for movies by title and view that movie's details.  A user can also see top rate movies by clicking the <b>Top Movies</b> button</p>

![step 2](https://user-images.githubusercontent.com/95776577/188296031-01b7d35f-cf38-49e0-9bd4-8cc33aa1264b.gif)


<!-- SCENARIO3 -->
<h2 id="scenario3"> :small_orange_diamond: Scenario 3: Create a Viewing Party </h2>
<p>A user can select a movie and create a viewing party for that movie.</p>


![step 3](https://user-images.githubusercontent.com/95776577/188296382-4d1656c0-a27a-44c2-ba90-ff262ab24d21.gif)

<!-- SCENARIO4 -->
<h2 id="scenario4"> :small_orange_diamond: Scenario 4: View User Dashboard </h2>
<p>A user can view the viewing parties they are hosting, as well as the parties they have been invited to.</p>

![step 4](https://user-images.githubusercontent.com/95776577/188296671-a1de8a83-b5a5-4099-853c-a167471fa152.gif)


<!-- CREDITS -->
<h2 id="credits"> :scroll: Credits</h2>
<h3>John Santosuosso</h3>

[![GitHub Badge](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/johnsantosuosso)
[![LinkedIn Badge](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/john-santosuosso)

<p>Project inspired and guided by Turing School of Software and Design's <a href="https://developers.themoviedb.org/3/getting-started/introduction"> Viewing Party Lite.</a></p>

