using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DialogueManager : MonoBehaviour {

	public Text dialogueText;
	public Text buttonText;
	
	[SerializeField] RectTransform speechPanel;
	[SerializeField] Image continueButton;

	[Range(0.1f, 1.0f)]
	[SerializeField] float fadeTime;

	private Queue<string> sentences;

	bool isTalking;

	// Use this for initialization
	void Start () {
		isTalking = false;
		sentences = new Queue<string>();
	}

	public bool GetIsTalking()
	{
		return isTalking;
	}

	public void StartDialogue(Dialogue dialogue)
	{
		isTalking = true;

		speechPanel.anchoredPosition = dialogue.boxLocation;
		speechPanel.gameObject.GetComponent<Image>().CrossFadeAlpha(1, fadeTime, false);

		ChangeButtonAppearance();
		sentences.Clear();

		foreach (string sentence in dialogue.sentences)
		{
			sentences.Enqueue(sentence);
		}
		DisplayNextSentence();
	}

	public void StartDialogueSimple(Dialogue dialogue)
	{

		speechPanel.gameObject.GetComponent<Image>().CrossFadeAlpha(1, fadeTime, false);
		sentences.Clear();

		foreach (string sentence in dialogue.sentences)
		{
			sentences.Enqueue(sentence);
		}
		DisplayNextSentence();
	}

	public void DisplayNextSentence()
	{
		if (sentences.Count == 0)
		{
			isTalking = false;
			EndDialogue();
			return;
		}

		string sentence = sentences.Dequeue();
		StopAllCoroutines();
		StartCoroutine(TypeSentence(sentence));
	}

	IEnumerator TypeSentence (string sentence)
	{
		dialogueText.text = "";
		foreach (char letter in sentence.ToCharArray())
		{
			dialogueText.text += letter;
			yield return null;
		}
	}

	private void EndDialogue()
	{
		speechPanel.gameObject.GetComponent<Image>().CrossFadeAlpha(0, fadeTime, false);
		dialogueText.text = "";
		ChangeButtonAppearance();
	}

	private void ChangeButtonAppearance()
	{
		Color maroon = new Color32(0x80, 0x00, 0x00, 0xFF);
		Color cream = new Color32(0xFF, 0xFD, 0xD0, 0xFF);

		if (isTalking)
		{
			continueButton.color = maroon;
			buttonText.color = cream;
			buttonText.text = "continue ~";
			continueButton.rectTransform.sizeDelta = new Vector2(160, 30);
			buttonText.fontSize = 14;
		}
		else
		{
			continueButton.color = cream;
			buttonText.color = maroon;
			buttonText.text = "next !";
			continueButton.rectTransform.sizeDelta = new Vector2(175, 100);
			buttonText.fontSize = 36;
		}
	}

	public void HidePanel(bool isHidden)
	{
		speechPanel.gameObject.SetActive(!isHidden);
	}
}
