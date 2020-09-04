using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BunnyMovement : MonoBehaviour {
	
	float walkSpeed = 2.0f;

	// Update is called once per frame
	void Update () {
		Vector3 input = new Vector3(Input.GetAxisRaw("Horizontal"), 0, Input.GetAxisRaw("Vertical"));
		Vector3 inputDir = input.normalized;

		//float speed = walkSpeed * inputDir.magnitude;
		transform.Translate(inputDir * walkSpeed * Time.deltaTime, Space.World);
	}
}
