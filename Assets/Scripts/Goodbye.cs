using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Goodbye : MonoBehaviour {
    
    public GameObject[] waypointList;

    [Range(90f, 180f)]
    [SerializeField] float doorRotationAngle;

    [SerializeField] OpenDoor door;

    public Dialogue dialogue;
    public DialogueManager dialogueManager;

    private int index;

    private void Start()
    {
        index = 0;

        if (waypointList[index])
        {
            MoveToWaypoint();
        }
    }

    private void MoveToWaypoint()
    {
        transform.position = waypointList[index].transform.position;
        Vector3 newRotation = new Vector3(waypointList[index].transform.eulerAngles.x,
            waypointList[index].transform.eulerAngles.y,
            waypointList[index].transform.eulerAngles.z);
        transform.eulerAngles = newRotation;

        if (waypointList[index].name == "Door Open")
        {
            dialogueManager.HidePanel(true);
            StartCoroutine(DoorOpenSequence());
        }
        else
        {
            SayGoodbye();
        }
    }

    IEnumerator DoorOpenSequence()
    {
        door.OpenMyDoor();

        yield return new WaitForSeconds(door.doorOpenTime);

        dialogueManager.HidePanel(false);
        SayGoodbye();
    }

    public void ButtonPressed ()
    {
        if (dialogueManager.GetIsTalking())
        {
            dialogueManager.DisplayNextSentence();
        }
        else
        {
            nextWaypoint();
        }
    }

    private void SayGoodbye()
    {
        waypointList[index].GetComponent<DialogueTrigger>().TriggerDialogue();
    }

    private void nextWaypoint()
    {
        index++;

        if (index > waypointList.Length - 1)
        {
            SceneManager.LoadScene("Clouds");
            return;
        }

        MoveToWaypoint();
    }
}
