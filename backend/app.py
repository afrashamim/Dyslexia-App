from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
from groq import Groq
import os

load_dotenv()

app = Flask(__name__)
CORS(app)

# Read the Groq API key from .env
api_key = os.getenv("GROQ_API_KEY")

if not api_key:
    raise ValueError("GROQ_API_KEY is not set in the .env file")

client = Groq(api_key=api_key)


@app.route("/")
def home():
    return "Dyslexia App Backend is running!"


@app.route("/simplify", methods=["POST"])
def simplify():
    data = request.get_json()

    text = data.get("text", "").strip()

    if not text:
        return jsonify({
            "error": "No text provided"
        }), 400

    response = client.chat.completions.create(
        model="openai/gpt-oss-20b",
        messages=[
            {
                "role": "system",
                "content": (
                    "You simplify text for readers with dyslexia. "
                    "Use short, clear sentences and simple words. "
                    "Keep the original meaning. "
                    "Do not add information. "
                    "Return only the simplified text."
                )
            },
            {
                "role": "user",
                "content": text
            }
        ],
        temperature=0.2
    )

    simplified_text = response.choices[0].message.content

    return jsonify({
        "simplifiedText": simplified_text
    })


if __name__ == "__main__":
    app.run(debug=True)