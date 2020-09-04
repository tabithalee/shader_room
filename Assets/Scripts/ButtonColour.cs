using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class ButtonColour : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler
{

	[SerializeField] Text buttonText;

	Color greenBlue = new Color32(0x6B, 0x9A, 0x8C, 0xFF);
	Color pink = new Color32(0x9A, 0x6B, 0x6B, 0xFF);

	void Start ()
	{
		buttonText.color = greenBlue;
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		buttonText.color = pink;
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		buttonText.color = greenBlue;
	}
}
