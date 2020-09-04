using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour {

	[Range(0.0f, -5.0f)]
	public float mySliderFloat = -1.0f;

	// Update is called once per frame
	void Update () {
		transform.Rotate(0, mySliderFloat, 0);
	}
}
