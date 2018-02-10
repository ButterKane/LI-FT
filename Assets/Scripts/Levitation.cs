using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Levitation : MonoBehaviour {


	public Rigidbody myRigidbody;
	public Text myText;
	public float forceMultiplicator = 100;

	private float t = 0.0f;
	public float lerpSpeed = 0.05f;

	private Ray myRay;
	public float myRayLength = 100.0f;

	private Vector3 tempGravity = Physics.gravity;



	void FixedUpdate () 
	{
		LevitationRaycast ();

	}

	public void LevitationRaycast()
	{
		Vector3 raycastOffset = -transform.right;

		float tempGravityValue = tempGravity.y;

		myRay.origin = transform.position + raycastOffset;
		myRay.direction = -Vector3.up;

		RaycastHit hit;					

		Debug.DrawRay (myRay.origin, myRay.direction*myRayLength, Color.green);

		if(Physics.Raycast(myRay.origin, myRay.direction, out hit, myRayLength))
		{

			Vector3 pos = gameObject.transform.position;

			float myForce = forceMultiplicator / hit.distance ;

			myRigidbody.AddForce (new Vector3 (0, myForce, 0));

			Quaternion rotMinimum = transform.rotation;
			Quaternion rotMaximum = Quaternion.FromToRotation (transform.up, hit.normal) * transform.rotation;
			transform.rotation =  Quaternion.Lerp ( rotMinimum , rotMaximum, t);

			t += lerpSpeed * Time.deltaTime;



	//		Debug.Log ("ActualGravity = " + Physics.gravity);
			Physics.gravity  = tempGravity + new Vector3 (0, -hit.distance*1.2f,0); 
//			Debug.Log ("distance = " + hit.distance);
//			Debug.Log ("12323");

			if (Physics.gravity.y > tempGravityValue-3.5f) 
			{

//				Debug.Log ("Reference gravity =" + tempGravityValue);
//				Debug.Log ("Actual gravity =" + Physics.gravity.y);
				Physics.gravity = tempGravity;
			}



		}
	}
}


