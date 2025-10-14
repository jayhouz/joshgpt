# from google import genai

# client = genai.Client()

# result = client.models.embed_content(
#         model="gemini-embedding-001",
#         contents= [
#             "What is the meaning of life?",
#             "What is the purpose of existence?",
#             "How do I bake a cake?"
#         ]
#         )

# for embedding in result.embeddings:
#     print(embedding)

####### Embedding Size ###############

from google import genai
from google.genai import types

client = genai.Client()

result = client.models.embed_content(
    model="gemini-embedding-001",
    contents="What is the meaning of life?",
    config=types.EmbedContentConfig(output_dimensionality=768)
)

[embedding_obj] = result.embeddings
embedding_length = len(embedding_obj.values)

print(f"Length of embedding: {embedding_length}")
print(f"Embeddings: {embedding_obj}")