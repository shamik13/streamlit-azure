from transformers import pipeline
from transformers.pipelines import TextGenerationPipeline
import streamlit as st

device = 'cpu'

@st.cache(allow_output_mutation=True, suppress_st_warning=True)
def load_model() -> TextGenerationPipeline:
    return pipeline("text-generation", model="model/")


def main():
    model = load_model()
    st.header("Create your own Harry Potter Story ⚡🧙")
    text = st.text_area(
        "Prompt:",
        height=100,
        max_chars=5000,
    )
    slider = st.slider(
        "Max story length (longer prompts will take more time to generate):",
        50,
        1000
    )
    if len(text) + slider > 5000:
        st.warning("Your story cannot be longer than 5000 characters!")
        st.stop()
    button_generate = st.button("Generate Story")

    if button_generate:
        try:
            outputs = model(
                text,
                do_sample=True,
                max_length=len(text) + slider,
                top_k=50,
                top_p=0.95,
                num_return_sequences=1,
            )
            output_text = outputs[0]["generated_text"]
                
            st.markdown(
                '<h2 style="font-family:Courier;text-align:center;">Your Story</h2>',
                unsafe_allow_html=True,
            )
            st.markdown(
                f'<p style="font-family:Courier;text-align:center;">{output_text}</p>',
                unsafe_allow_html=True,
            )
        except:
            pass
if __name__ == "__main__":
    main()