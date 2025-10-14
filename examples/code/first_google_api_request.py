from google import genai

# The client gets the API key from the environment variable `GEMINI_API_KEY`.
client = genai.Client()

response = client.models.generate_content(
    model="gemini-2.5-flash", 
    contents="Explain how AI works in a few words"
)
print(response.text)

### Example content
# 1. contents = Explain how AI works in a few words: 
#    results = 'AI learns patterns from data to make decisions or predictions.'
# 2. contents = Help me design an Application (AM) Module for BMI calculation 
#               and user health tips that each step from inputing weight and height 
#               and recommendations by llm GPT model
#    results = a long markdwon document - I saved this separately as .md file.
