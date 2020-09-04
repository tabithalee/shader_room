using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DelayedSceneLoader : MonoBehaviour {

	[SerializeField] float delay = 2.5f;

	// Use this for initialization
	void Start () {
		StartCoroutine(LoadIntro(delay));
	}

	IEnumerator LoadIntro(float delay)
	{
		yield return new WaitForSeconds(delay);

		SceneManager.LoadScene("Intro");
	}
}
