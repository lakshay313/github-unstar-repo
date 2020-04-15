# github-unstar-repo

Ruby Script to remove starred repositories using the Personal Access Tokens.

## Command

Clone the repository to your system and then run the following command

  ```
  ruby unstar.rb
  ```
  
## Parameters

You need to set the following parameters :

  ```
$access_token = ':PERSONAL-ACCESS-TOKEN'
$username = ':USERNAME'
$limit = ':LIMIT'
```

Note : Max-limit can only be 100 repositories at a time as the max page size of Github GET API is 100.

## Output

The specified number of repositories will be unstarred and the logs for the same will be stored in `response.csv` file. 
