using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MaterialSelection : MonoBehaviour {

    public Material[] materialList;

    public DialogueTrigger dialoguetrigger;

    private Renderer m_Rend;

    private int index;

	private void Start()
    {
        index = PlayerPrefs.GetInt("MaterialSelected");

        m_Rend = GetComponent<Renderer>();

        if (materialList[index])
        {
           m_Rend.material = materialList[index];
        }
    }

    public void startDialogueButton()
    {
        dialoguetrigger.TriggerDialogueSimple();
    }

    public void ToggleLeft()
    {
        index--;

        if (index < 0)
        {
            index = materialList.Length - 1;
        }

        m_Rend.material = materialList[index];
    }

    public void ToggleRight()
    {
        index++;

        if (index > materialList.Length - 1)
        {
            index = 0;
        }

        m_Rend.material = materialList[index];
    }

    public void Confirm()
    {
        PlayerPrefs.SetInt("MaterialSelected", index);
        SceneManager.LoadScene("Goodbye");
    }

}
