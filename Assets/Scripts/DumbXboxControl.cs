using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DumbXboxControl : MonoBehaviour {


	public float turnspeed = 45;

	private Rigidbody rig;

	public float vitesseMax;
	public float vitesse;
	public float lastPickup;

	public GameObject LaCamera;

	public float StrafeBrakeFactor;

	public bool IsGameStarted;

	private float lStickX;
	private float rStickX;
	public float Trigger;

	// Use this for initialization
	void Start () 
	{
		rig = GetComponent<Rigidbody> ();

		var PickupSpeed = 50f;
		lastPickup = PickupSpeed;

		rig.centerOfMass = new Vector3(0,0,0);

	}
	
	void Update () 
//	void FixedUpdate () 
	{
		if (IsGameStarted == true) {

//		Debug.DrawLine (transform.position - Vector3.up*100, transform.position + Vector3.up*100,Color.magenta);


			debugDirection ();
			getSpeed ();
			StrafeBrake ();
			vitesseMax = lastPickup * 3f;

			lStickX = Input.GetAxis ("Xbox_LStickX");
			rStickX = Input.GetAxis ("Xbox_RStickX");
			Trigger = Input.GetAxis ("Xbox_Triggers");

	

//		transform.Rotate (new Vector3 (0, lStickX, 0), turnspeed * Time.deltaTime);

			rig.AddTorque (new Vector3 (0, lStickX * turnspeed, 0));

//		transform.Translate (-(new Vector3 (0, 0, rStickX))/2);

			rig.AddRelativeForce (new Vector3 (0, 0, -rStickX * 40));

			if (Trigger < 0) {
				if (vitesse < vitesseMax) {
//				Vector3 Direction = transform.right;
//				rig.AddForce (Direction * lastPickup);
					rig.AddRelativeForce (new Vector3 (lastPickup, 0, 0));
					//				transform.Translate (Vector3.forward * lastPickup);
				} 
			}

			if (Trigger > 0) {
				if (vitesse < vitesseMax) {
//			Vector3 Direction = transform.right;
//				Grig.AddForce (Direction * -lastPickup);
					rig.AddRelativeForce (new Vector3 (-lastPickup, 0, 0));
					//				transform.Translate (Vector3.forward * lastPickup);
				}
			}
		} 
		else
		{
			transform.position = transform.position;
		}
	}


	void debugDirection()
	{

		Ray myRay = new Ray ();
		myRay.origin = transform.position;
		myRay.direction = transform.right;
		float myRayLength = 100.0f;

		Debug.DrawRay (myRay.origin, myRay.direction * myRayLength, Color.red);
	}

	void getSpeed ()
	{
		Vector3 vecteurVitesse = GetComponent<Rigidbody> ().velocity;
		vitesse = vecteurVitesse.magnitude;
		LaCamera.GetComponent<Camera> ().fieldOfView = 70 + (vitesse/10);		// La FOV "s'étire" si tu vas vite => C'est cool comme feedback
	}


	void StrafeBrake ()
	{
		Vector3 locVel = transform.InverseTransformDirection(rig.velocity);		//Vitesse locale de l'objet, traduit en un vecteur 3

		rig.AddRelativeForce (new Vector3 (0,0,-locVel.z * StrafeBrakeFactor));							//On réduit la vitesse de strafe latéral selon le Factor

	}
}
