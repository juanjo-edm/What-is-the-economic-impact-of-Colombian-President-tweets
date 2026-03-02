


# Introduction -------

# This script is designed to automate the collection of publicly
# available data from the Twitter (X) platform using web scraping
# techniques and/or available data access methods.
#
# The main objective is to systematically extract structured data
# for subsequent quantitative and qualitative analysis.
#
# The collected information may include posts, hashtags, keywords,
# engagement metrics (e.g., likes, retweets, replies), and other
# relevant metadata depending on the research objectives.
#
# This automated process improves efficiency, reproducibility,
# and scalability, while reducing manual intervention and potential
# errors during data collection.
#
# The script structure ensures a transparent and organized workflow
# for data extraction, storage, and further analysis.



# Packages -------

# Install and load required packages using pacman.
# If a package is not installed, pacman will install it first.

if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  academictwitterR,
  dplyr,
  tidyr,
  stringr,
  lubridate,
  readr
)


# Authentication -------
# This script uses Academic Research access through the
# academictwitterR package.
# Authentication credentials must be configured prior to use.

# Example (do NOT share your token publicly):
# set_bearer_token("YOUR_BEARER_TOKEN_HERE")

# Ensure your token is stored securely (e.g., in environment variables).



Sys.setenv(TWITTER_BEARER = "YOUR_BEARER_TOKEN_HERE")




# Data Collection -------

# This section queries Twitter (X) using the Academic Research API.
# The search parameters (keywords, hashtags, date range, etc.)
# should be defined according to the research objectives.

# Example structure:
# tweets <- search_tweets(
#   query = "your_keyword OR #yourhashtag",
#   start_time = "YYYY-MM-DDT00:00:00Z",
#   end_time   = "YYYY-MM-DDT00:00:00Z",
#   max_results = 100
# )

# The retrieved dataset may include:
# - Tweet text
# - Author information
# - Creation date
# - Engagement metrics
# - Public metadata

query_detallado <- paste(
  "(",
  '"Gustavo Petro" OR @petrogustavo OR Petro',
  ")",
  "lang:es",
  "-is:retweet",
  "-is:reply",
  "-is:quote",
  "-has:links"
)

# Query Definition ----
# The search query is constructed to filter tweets according to
# specific inclusion and exclusion criteria.

# The query includes:
# - Mentions of the keyword "Gustavo Petro"
# - The official handle @petrogustavo
# - The surname "Petro"
#
# Language filter:
# - lang:es ensures that only tweets written in Spanish are retrieved.
#
# Exclusion filters:
# - -is:retweet   → Removes retweets to avoid duplicated content.
# - -is:reply     → Excludes replies to focus on original posts.
# - -is:quote     → Excludes quote tweets to avoid secondary content.
# - -has:links    → Removes tweets containing external links,
#                   ensuring the dataset focuses on textual content.
#
# Overall, this query aims to collect original Spanish-language
# tweets related to the specified political figure while minimizing
# duplication and external content noise.


tweets <- get_all_tweets(
  query = query_detallado,
  start_tweets = "2022-08-07T00:00:00Z",
  end_tweets   = "2022-08-08T23:59:59Z",
  n = 10
)


# Data Cleaning -------

# After extraction, the data should be processed to:
# - Remove duplicates
# - Handle missing values
# - Standardize text (lowercase, remove URLs, etc.)
# - Format dates properly
# - Select relevant variables for analysis

# Example:
# tweets_clean <- tweets %>%
#   distinct() %>%
#   mutate(text = str_to_lower(text))

tweets_clean <- tweets %>%
  select(
    id,
    created_at,
    text,
    author_id,
    lang,
    conversation_id,
    possibly_sensitive
  )



# Data Export -------

# The final dataset can be saved for further analysis.

write_csv(tweets_clean, "tweets_agosto_2022.csv")



# Ethical Considerations -------

# This data collection process relies exclusively on publicly
# available information accessed through the official API.
#
# No private or restricted data is collected.
# The use of the data should comply with Twitter/X API policies
# and applicable research ethics guidelines.
#
# Data is intended solely for academic/research purposes.

