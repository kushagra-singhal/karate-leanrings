Feature: Assignment 1 - Store JSON and CSV

  Background:
    * configure ssl = true
    * url baseUrl
    * def customFolder = '../files'

  Scenario: 1. Get Posts and Create Files
    Given path '/posts'
    When method GET
    Then status 200

    * def jsonResponse = response
    * def customFolderPath = '/home/kushas/Documents/Learnings/Karate/karateLearning/files'

    * eval org.assignments.FileCreator.createJsonFile(jsonResponse)
#    * eval Learnings.utils.FileCreator.createJsonFile(jsonResponse)
    * def JavaDemo = Java.type('org.assignments.FileCreator')
#    * def JavaDemo = Java.type('Learnings.utils.FileCreator')
    * def result1 = JavaDemo.createJsonFile(jsonResponse)

  Scenario: 2. Send GET request to /posts
    Given path '/posts'
    When method GET
    Then status 200
    * def filename = (response[0].id % 2) == 0 ? '@tag1' : '@tag2'
    * def result = call read(filename)

  @tag1 @ignore
  Scenario:
    * print 'Even number Scenario'

  @tag2 @ignore
  Scenario:
    * print 'Odd number Scenario'

  Scenario: 3. Send GET request to /posts
    Given path '/posts'
    When method GET
    Then status 200

    * def csvFileName = customFolder + '/response2.csv'
    * def data = karate.toCsv(response)
    * karate.write(data, csvFileName)
    * call read('@tag10') { file: '#(data)' }

  @tag10 @ignore
  Scenario: 3. Read CSV Data
    * print 'File Content:', file

  Scenario: 4. Send GET request to /posts
    Given path '/posts'
    When method GET
    Then status 200

    * def jsFunction =
        """
        function createUserIdsArray(response) {
         return response.map(post=>({
           id:post.id,
           title:post.title,
           userId:post.userId,
         }))
        }
        """
    * def modifiedJson = jsFunction(response)

    * print 'modified json : ',modifiedJson

  Scenario: 5. Execute JavaScript to Create Array
    Given path '/posts'
    When method GET
    Then status 200

    * def jsFunction =
        """
        function createUserIdsArray(response) {
         return response.filter((post,ind)=>{
            if(ind==0)return true;
            return !(post.userId===response[ind-1].userId)
          })
          .map(post=>post.userId)
        }
        """
    * def userIdsArray = jsFunction(response)
    * print 'User IDs Array:', userIdsArray
