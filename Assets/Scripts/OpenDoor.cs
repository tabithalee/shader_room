using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OpenDoor : MonoBehaviour {
	
	public bool startOpenDoor;
	public float openAngle;
	public float openingSeconds;
	public float doorOpenTime = 2f;

	[SerializeField] Transform hinge;

	
	void Start ()
	{
		transform.position = new Vector3(-1.3f, 1.7f, 9.71f);
		transform.eulerAngles = new Vector3(0.0f, 180.0f, 0.0f);
	}

	public void OpenMyDoor()
	{
		StartCoroutine(LerpRotation());
		return;
	}

	// Update is called once per frame
	IEnumerator LerpRotation () {
		float startTime = Time.time;
		float angleProgress = 0.0f;

		while ((openAngle - angleProgress) > 0.99f)
		{

			float fracComplete = (Time.time - startTime) * openingSeconds;
			float newAngleProgress = Mathf.SmoothStep(0.0f, openAngle, fracComplete);
			float amountRotated = newAngleProgress - angleProgress;

			transform.RotateAround(hinge.position, Vector3.up, amountRotated);

			//GetComponent<Renderer>().material.mainTextureScale = new Vector2(1, -1);

			angleProgress = newAngleProgress;
			yield return null;
		}
	}
}
