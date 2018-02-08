using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour {


	public Transform TargetPos;		
	public float PosLerpSpeed;

	public Transform TargetToLook;		
	public float RotLerpSpeed;

	public Transform MenuCameraPos;
	public Transform MenuCameraLook;
	
	// Update is called once per frame
//	void FixedUpdate () 
	void Update () 
//	void LateUpdate () 
	{
		bool actifOuPas = GetComponent<Menu> ().isGameOn;
		Debug.Log (actifOuPas);

		if (actifOuPas == true) 
		{
			transform.position = Vector3.Lerp (transform.position, TargetPos.position, PosLerpSpeed);

			Vector3 PosToLook = TargetToLook.position - transform.position;
			Quaternion Rot = Quaternion.LookRotation (PosToLook);
			transform.rotation = Quaternion.Lerp (transform.rotation, Rot, RotLerpSpeed);
			Debug.Log ("Camera normale");
		}

		else if (actifOuPas == false) 
		{
			transform.position = Vector3.Lerp (transform.position, MenuCameraPos.position, PosLerpSpeed);

			Vector3 PosToLook = MenuCameraLook.position - transform.position;
			Quaternion Rot = Quaternion.LookRotation (PosToLook);
			transform.rotation = Quaternion.Lerp (transform.rotation, Rot, RotLerpSpeed);
			Debug.Log ("Camera Menu");
		}

	}
}
